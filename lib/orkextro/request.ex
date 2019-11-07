defmodule Orkextro.Request do
  @moduledoc """
    Collection of API request handlers
  """
  alias Orkextro.Request.{
    Auth,
    Order
  }

  defdelegate authenticate(username, password), to: Auth
  defdelegate create_order(params, api_key), to: Order, as: :create
  defdelegate get_order(order_id, api_key), to: Order, as: :get
end
