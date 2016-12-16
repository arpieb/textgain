defmodule Textgain.Gender do

  @moduledoc """
  Provides an interface into the Gender service provided by Textgain.
  """
  defstruct [:gender, :confidence]
  use Textgain, service: "gender"

end
