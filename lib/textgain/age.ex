defmodule Textgain.Age do

  @moduledoc """
  Provides an interface into the Age service provided by Textgain.
  """
  defstruct [:age, :confidence]
  use Textgain.Service, name: "age"

end
