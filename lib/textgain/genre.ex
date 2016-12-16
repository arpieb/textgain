defmodule Textgain.Genre do

  @moduledoc """
  Provides an interface into the Genre service provided by Textgain.
  """
  defstruct [:genre, :review, :confidence]
  use Textgain.Service, name: "genre"

end
