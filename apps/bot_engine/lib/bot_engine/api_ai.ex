defmodule BotEngine.ApiAi do
  @base_url "https://api.api.ai/v1/"
  @default_reply "..."

  alias BotEngine.Response

  def query(session_id, message) do
    headers = %{"Authorization" =>  "Bearer #{config[:client_access_token]}"}
    params = %{
      v: 20150910,
      query: message,
      lang: "EN",
      sessionId: session_id
    }

    response = HTTPoison.get!(resource_url("query"), headers, params: params)
    |> process_body
    |> generate_response

    {:ok, response}
  end

  defp config, do: Application.get_env(:bot_engine, __MODULE__)

  defp resource_url("/" <> name), do: resource_url(name)
  defp resource_url(name), do: "#{@base_url}#{name}"

  defp process_body(%{body: body}), do: Poison.decode!(body)

  defp generate_response(result = %{"result" => %{"fulfillment" => %{"speech" => message}}}) do
    %Response{
      message: message,
      action: result["action"],
      parameters: result["parameters"],
      metadata: result["metadata"]
    }
  end

  defp generate_response(_), do: %Response{message: @default_reply}
end
