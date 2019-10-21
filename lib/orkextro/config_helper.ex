defmodule Orkextro.ConfigHelper do
  def get_endpoint do
    Application.get_env(:orkextro, :production_endpoint)
  end
end
