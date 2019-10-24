defmodule Orkextro.Auth do
  @moduledoc """
    This module handles auth via config
    Transfer to Application / GenServer later on
  """
  alias Orkextro.ConfigHelper

  def get_access_token() do
    username = Application.get_env(:orkextro, :username)
    password = Application.get_env(:orkextro, :password)

    do_get_access_token(username, password)
  end

  defp do_get_access_token(username, password) when is_nil(username) or is_nil(password) do
    {:error, "Missing parameters: username and password are required parameters."}
  end

  defp do_get_access_token(username, password) do
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
