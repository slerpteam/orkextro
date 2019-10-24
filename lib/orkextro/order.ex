defmodule Orkextro.Order do
  @moduledoc """
  This module handles delivery orders
  """
  import Orkextro.ConfigHelper

  defp build_headers() do
    api_key = get_api_key()
    ["Content-Type": "application/json", "api-key": api_key]
  end

  defp build_url() do
    "#{get_endpoint()}/orders"
  end

  def create(params) do
    with {:ok, %{"id" => order_id}} <- do_create(params),
         {:ok, order} <- get(order_id) do
      {:ok, order}
    else
      {:error, error} -> {:error, error}
      edge -> {:error, edge}
    end
  end

  def do_create(params) do
    case HTTPoison.post(
           build_url(),
           Jason.encode!(params),
           build_headers()
         ) do
      {:ok, %{status_code: 201, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %{status_code: _not_ok, body: body} = all} ->
        IO.puts("#{inspect(all)}")
        {:error, Jason.decode!(body)}

      {:error, error} ->
        {:error, error}
    end
  end

  def get(order_id) do
    params = %{
      id: order_id
    }

    case HTTPoison.post(build_url(), Jason.encode!(params), build_headers()) do
      {:ok, %{status_code: 400, body: body}} -> {:error, Jason.decode!(body)}
      {:ok, %{status_code: 201, body: body}} -> {:ok, Jason.decode!(body)}
      {:error, error} -> {:error, error}
    end
  end
end
