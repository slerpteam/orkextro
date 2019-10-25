defmodule Orkextro.ConfigHelper do
  def get_endpoint do
    Application.get_env(:orkextro, :endpoint)
  end
end
