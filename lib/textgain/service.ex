defmodule Textgain.Service do
  @moduledoc """
  Provides a base for building Textgain REST service modules.
  """

  defmacro __using__(service) do
    quote bind_quoted: [service: service] do

    end
  end

end
