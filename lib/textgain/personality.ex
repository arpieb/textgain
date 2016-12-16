defmodule Textgain.Personality do

  @moduledoc """
  Provides an interface into the Personality service provided by Textgain.
  """
  defstruct [:personality, :confidence]
  use Textgain.Service, name: "personality"

end
