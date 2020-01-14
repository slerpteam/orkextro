defmodule Orkextro.Request.Order do
  @moduledoc """
  This module handles delivery orders
  """

  defp build_headers(access_token) do
    ["Content-Type": "application/json", Authorization: "Bearer #{access_token}"]
  end

  defp build_url() do
    "#{Orkextro.ConfigHelper.get_endpoint()}/orders"
  end

  def create(params, access_token) do
    case HTTPoison.post(
           build_url(),
           Jason.encode!(params),
           build_headers(access_token)
         ) do
      {:ok, %{status_code: 201, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %{status_code: _not_ok, body: body}} ->
        {:error, Jason.decode!(body)}

      {:error, error} ->
        {:error, error}
    end
  end

  def get(order_id, access_token) do
    case HTTPoison.get("#{build_url()}/#{order_id}", build_headers(access_token)) do
      {:ok, %{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %{status_code: _not_ok, body: body}} ->
        {:error, Jason.decode!(body)}

      {:error, error} ->
        {:error, error}
    end
  end
end
