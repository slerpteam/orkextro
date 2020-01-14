defmodule Orkextro.Order do
  @moduledoc """
  Core auth module
  """
  @api Application.get_env(:orkextro, :api)

  def create(params, %{"username" => username, "password" => password}) do
    with {:ok, %{"accessToken" => access_token}} <- @api.authenticate(username, password),
         {:ok, %{"id" => order_id}} <- @api.create_order(params, access_token),
         {:ok, order} <- @api.get_order(order_id, access_token) do
      {:ok, order}
    else
      {:error, error} -> {:error, error}
      edge -> {:error, edge}
    end
  end

  def get(order_id, %{"username" => username, "password" => password}) do
    with {:ok, %{"accessToken" => access_token}} <- @api.authenticate(username, password),
         {:ok, order} <- @api.get_order(order_id, access_token) do
      {:ok, order}
    else
      {:error, error} -> {:error, error}
      edge -> {:error, edge}
    end
  end

  def get(order_id, access_token) do
    @api.get_order(order_id, access_token)
  end
end
