defmodule LinkServer do

    use GenServer
    require Logger

    def file_path(), do: if System.get_env("DEPLOYED") == "TRUE", do: "/opt/link_me", else: "data/link_server"
    @garbage_freq 600 * 1000

    def base_url(), do: "https://torrent.sceptical-forex.com:9000/"

    def start_link(_) do
        GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end

    def init(_) do
        Logger.info("Starting #{__MODULE__}")
        links = case File.read(file_path()) do
            {:ok, l} -> 
                :erlang.binary_to_term(l)
            _ -> 
                File.write!(file_path(), %{} |> :erlang.term_to_binary())
                %{}
        end
        Process.send_after(self(), :garbage_collect, @garbage_freq)
        {:ok, links}
    end

    def handle_info(:garbage_collect, links) do
        links = links |> Enum.reject(fn {_,v} -> v["expiration"] < :os.system_time(:seconds) end) |> Enum.into(%{})
        Process.send_after(self(), :garbage_collect, @garbage_freq)
        {:noreply, links}
    end

    def get_all_links(), do: GenServer.call(LinkServer, :get_all_links)
    def new_link(path, duration \\ 30), do: GenServer.call(LinkServer, {:new_link, path, duration})
    def delete_link(token), do: GenServer.call(LinkServer, {:delete_link, token})
    def verify_token(token), do: GenServer.call(LinkServer, {:verify_token, token})

    def handle_call({:new_link, path, duration}, _from, links) do
        token = :crypto.strong_rand_bytes(30) |> Base.encode64
        expiration =  :os.system_time(:seconds) + duration * 24*3600
        links = links |> Map.put(token, %{
            "path" => path,
            "expiration" => expiration,
            "link" => "#{base_url()}#{token |> URI.encode_www_form()}"
        })
        File.write!(file_path(), links |> :erlang.term_to_binary())
        {:reply, "#{base_url()}/#{token |> URI.encode_www_form()}", links}
    end

    def handle_call({:delete_link, token}, _from, links) do
        links = links |> Map.pop(token) |> elem(1)
        File.write!(file_path(), links |> :erlang.term_to_binary())
        {:reply, :ok, links}
    end

    def handle_call(:get_all_links, _from, links) do
        {:reply, links, links}
    end

    def handle_call({:verify_token, token}, _from, links) do
        case links[token] do
            nil -> {:reply, :invalid, links}
            l ->
                if l["expiration"] < :os.system_time(:seconds) do
                    {:reply, :invalid, links}
                else
                    {:reply, {:ok, l}, links}
                end
        end
    end
end