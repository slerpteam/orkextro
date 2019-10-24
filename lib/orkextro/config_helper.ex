defmodule Orkextro.ConfigHelper do
  def get_endpoint do
    Application.get_env(:orkextro, :endpoint)
  end

  def get_api_key do
    Application.get_env(:orkextro, :api_key)
  end
end
