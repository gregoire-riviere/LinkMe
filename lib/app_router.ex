defmodule AppRouter do
    require Logger
    use Plug.Router

    plug Plug.Static, at: "css", from: "web_build/css/"
    plug Plug.Static, at: "js", from: "web_build/js/"
    plug Plug.Static, at: "img", from: "web_build/img/"
    plug Plug.Static, at: "font", from: "web_build/font/"
    plug :match
    plug :dispatch

    get "/dl/:token" do
        Logger.debug(token)
        case LinkServer.verify_token(token) do
            :invalid -> 
                send_resp(conn, 403, "Lien incorrect. Votre lien a potentiellement expire ou est invalide. Demandez en un autre!")
            {:ok, %{"path" => path}} ->
                if File.exists?(path) do
                    filename = Path.basename(path)

                    conn = conn
                    |> put_resp_header("content-disposition", "attachment; filename=\"#{filename}\"")
                    |> send_chunked(200)

                    File.stream!(path, [], 10000) |>
                    Stream.each(fn ch -> chunk(conn, ch) end) |> 
                    Stream.run()

                    conn
                else send_resp(conn, 404, "Lien correct, mais fichier introuvable sur le serveur. Il a peut-etre ete deplace par l'administrateur.") end
        end
    end

    # forward "/api", to: PersonalWebsite.Apis

    get "/" do
        put_resp_content_type(conn, "text/html") |>
        send_file(200, "web_build/html/home.html")
    end
  
    match _ do
        send_resp(conn, 404, "")
    end

  end
  