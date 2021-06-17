defmodule Orkextro.Request.Order do
  @moduledoc """
  This module handles delivery orders
  """

  defp build_headers(api_key) do
    ["Content-Type": "application/json", "api-key": api_key]
  end

  defp opts do
    [timeout: 50_000, recv_timeout: 50_000]
  end

  defp build_url() do
    "#{Orkextro.ConfigHelper.get_endpoint()}/orders"
  end

  def create(params, api_key) do
    case HTTPoison.post(
           build_url(),
           Jason.encode!(params),
           build_headers(api_key),
           opts()
         ) do
      {:ok, %{status_code: status_code, body: body}}
      when status_code >= 200 and status_code < 300 ->
        {:ok, parse(body)}

      {:ok, %{status_code: _not_ok, body: body}} ->
        {:error, parse(body)}

      {:error, error} ->
        {:error, error}
    end
  end

  defp parse(body) do
    case Jason.decode(body) do
      {:ok, parsed} -> parsed
      {:error, _} -> body
    end
  end

  def get(order_id, api_key) do
    case HTTPoison.get("#{build_url()}/#{order_id}", build_headers(api_key), opts()) do
      {:ok, %{status_code: 200, body: body}} -> {:ok, Jason.decode!(body)}
      {:ok, %{status_code: _not_ok, body: body}} -> {:error, Jason.decode!(body)}
      {:error, error} -> {:error, error}
    end
  end

  def cancel(order_id, api_key) do
    case HTTPoison.post(
           "#{build_url()}/#{order_id}/cancel",
           Jason.encode!(%{}),
           build_headers(api_key),
           opts()
         ) do
      {:ok, %{status_code: status_code, body: _body}}
      when status_code >= 200 and status_code < 300 ->
        {:ok, %{"id" => order_id}}

      {:ok, %{status_code: _not_ok, body: body}} ->
        {:error, Jason.decode!(body)}

      {:error, error} ->
        {:error, error}
    end
  end
end
