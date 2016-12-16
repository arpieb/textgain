defmodule Textgain.Education do

  @moduledoc """
  Provides an interface into the Education service provided by Textgain.
  """
  defstruct [:education, :confidence]
  use Textgain, service: "education"

end
