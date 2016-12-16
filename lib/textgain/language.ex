defmodule Textgain.Language do

  @moduledoc """
  Provides an interface into the Language service provided by Textgain.
  """
  defstruct [:language, :confidence]
  use Textgain.Service, name: "language"

end
