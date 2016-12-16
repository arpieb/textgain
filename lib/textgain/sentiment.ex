defmodule Textgain.Sentiment do

  @moduledoc """
  Provides an interface into the Sentiment service provided by Textgain.
  """
  defstruct [:polarity, :confidence]
  use Textgain, service: "sentiment"

end
