defmodule LinkMe do
  def start(_type, _args) do

    plug_child = 
      {Plug.Cowboy, 
      scheme: :http, 
      plug: AppRouter, 
      options: [port: 8443]}

    children = [
      plug_child,
      {LinkServer, []}
    ]
    IO.inspect(children)
    {:ok, _pid} = Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end
end
