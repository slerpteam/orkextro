defmodule Orkextro.Test.ConfigHelper do
  use ExUnit.Case

  test "Retrieves current env variable set to config" do
    assert Orkextro.ConfigHelper.get_endpoint() == "https://api.test.orkestro.io"
  end
end
