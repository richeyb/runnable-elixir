defmodule RunnableTest do
  use ExUnit.Case
  doctest Runnable

  test "greets the world" do
    assert Runnable.hello() == :world
  end
end
