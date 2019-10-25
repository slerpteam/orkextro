defmodule Orkextro.Request.Auth do
  @moduledoc """
    This module handles auth via config
    Transfer to Application / GenServer later on
  """
  alias Orkextro.ConfigHelper

  def authenticate(username, password) do
    params = %{
      username: username,
      password: Base.encode64(password)
    }

    case HTTPoison.post("#{ConfigHelper.get_endpoint()}/users/sign-in", Jason.encode!(params),
           "Content-Type": "application/json"
         ) do
      {:ok, %{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %{status_code: _not_ok, body: body}} ->
        {:error, Jason.decode!(body)}

      {:error, error} ->
        {:error, error}
    end
  end
end
