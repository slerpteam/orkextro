defmodule Orkextro.Request.Order do
  @moduledoc """
  This module handles delivery orders
  """

  defp build_headers(api_key) do
    ["Content-Type": "application/json", "api-key": api_key]
  end

  defp build_url() do
    "#{Orkextro.ConfigHelper.get_endpoint()}/orders"
  end

  def create(params, api_key) do
    with {:ok, %{"id" => order_id}} <- do_create(params, api_key),
         {:ok, order} <- get(order_id, api_key) do
      {:ok, order}
    else
      {:error, error} -> {:error, error}
      edge -> {:error, edge}
    end
  end

  def do_create(params, api_key) do
    case HTTPoison.post(
           build_url(),
           Jason.encode!(params),
           build_headers(api_key)
         ) do
      {:ok, %{status_code: 201, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %{status_code: _not_ok, body: body}} ->
        {:error, Jason.decode!(body)}

      {:error, error} ->
        {:error, error}
    end
  end

  def get(order_id, api_key) do
    params = %{
      id: order_id
    }

    case HTTPoison.post(build_url(), Jason.encode!(params), build_headers(api_key)) do
      {:ok, %{status_code: 400, body: body}} -> {:error, Jason.decode!(body)}
      {:ok, %{status_code: 201, body: body}} -> {:ok, Jason.decode!(body)}
      {:error, error} -> {:error, error}
    end
  end
end
