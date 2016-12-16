defmodule Textgain.POS do

  @moduledoc """
  Provides an interface into the part of speech (POS) tagging service provided by Textgain.
  """
  defstruct [:text, :confidence]
  use Textgain.Service, name: "tag"

end
