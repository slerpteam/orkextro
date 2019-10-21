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
    case HTTPoison.post("#{ConfigHelper.get_endpoint()}/users/sign-in", [], %{
           username: username,
           password: Base.encode64(password)
         }) do
      {:ok, %{status_code: 400, body: body}} -> {:error, Jason.decode!(body)}
      {:ok, %{status_code: 200, body: body}} -> {:ok, Jason.decode!(body)}
      {:error, error} -> {:error, error}
    end
  end
end
