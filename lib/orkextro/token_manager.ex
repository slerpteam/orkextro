defmodule Orkextro.TokenManager do
  use GenServer
  alias Orkextro.Auth

  def init(_) do
    case initial_token() do
      {:ok, result} -> {:ok, result}
      {:error, error} -> {:stop, error}
    end
  end

  defp initial_token do
    case Auth.get_access_token() do
      {:ok, result} ->
        {:ok, result}

      {:error, %{"errors" => errors}} ->
        {:error, errors |> hd |> Map.get("code")}

      _ ->
        {:error, "Auth failure"}
    end
  end
end
