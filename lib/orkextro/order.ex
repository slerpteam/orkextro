defmodule Orkextro.Order do
  @moduledoc """
  Core auth module
  """
  @api Application.get_env(:orkextro, :api)
  @api_key Application.get_env(:orkextro, :api_key)

  def create(params, api_key \\ @api_key) do
    with {:ok, %{"id" => order_id}} <- @api.create_order(params, api_key),
         {:ok, order} <- @api.get_order(order_id, api_key) do
      {:ok, order}
    else
      {:error, error} -> {:error, error}
      edge -> {:error, edge}
    end
  end

  def get(order_id, api_key \\ @api_key) do
    @api.get_order(order_id, api_key)
  end

  def cancel(order_id, api_key \\ @api_key) do
    @api.cancel_order(order_id, api_key)
  end
end
