defmodule Token do
    
    def base_path(), do: if System.get_env("DEPLOYED") == "TRUE", do: "/opt/link_me/", else: "/data/"

    def secret(), do: if System.get_env("DEPLOYED") == "TRUE", do: "#{base_path()}/link_server", else: "#{base_path()}/link_server"
    def generate_secret(), do: File.write!("#{base_path()}/secret", :crypto.strong_rand_bytes(60) |> Base.encode64)

    # duration will be in days
    def generate_token(path, duration \\ 30) do
        expiration =  :os.system_time(:seconds) + duration * 24*3600
        %{
            "path" => path,
            "expiration" => expiration,
            "sig" => :crypto.hash(:sha512, "#{path}:#{expiration}:#{secret()}") |> Base.encode64()
        } |> Poison.encode!() |> Base.encode64()
    end

end