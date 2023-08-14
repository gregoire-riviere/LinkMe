defmodule LinkMeTest do
  use ExUnit.Case
  doctest LinkMe

  test "greets the world" do
    assert LinkMe.hello() == :world
  end
end
