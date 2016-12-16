defmodule Textgain.Concepts do

  @moduledoc """
  Provides an interface into the Concepts service provided by Textgain.
  """
  defstruct [:concepts]
  use Textgain.Service, name: "concepts"

end
