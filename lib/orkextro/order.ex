defmodule Orkextro.Order do
  @moduledoc """
  This module handles delivery orders
  """
  alias Orkextro.{
    Auth,
    ConfigHelper
  }

  defp build_headers(access_token) do
    [Bearer: access_token, "Content-Type": "application/json"]
  end

  def create(params) do
    with {:ok, %{"access_token" => access_token}} <- Auth.get_access_token(),
         {:ok, %{"id" => order_id}} <- do_create(params, access_token),
         {:ok, order} <- get(order_id, access_token) do
      {:ok, order}
    else
      {:error, error} -> {:error, error}
      edge -> {:error, edge}
    end
  end

  def do_create(params, access_token) do
    case HTTPoison.post(
           "#{ConfigHelper.get_endpoint()}/orders",
           build_headers(access_token),
           params
         ) do
      {:ok, %{status_code: 400, body: body}} -> {:error, Jason.decode!(body)}
      {:ok, %{status_code: 201, body: body}} -> {:ok, Jason.decode!(body)}
      {:error, error} -> {:error, error}
    end
  end

  def get(order_id, access_token) do
    case HTTPoison.post("#{ConfigHelper.get_endpoint()}/orders", build_headers(access_token), %{
           id: order_id
         }) do
      {:ok, %{status_code: 400, body: body}} -> {:error, Jason.decode!(body)}
      {:ok, %{status_code: 201, body: body}} -> {:ok, Jason.decode!(body)}
      {:error, error} -> {:error, error}
    end
  end
end
