defmodule Textgain.Language do
  @moduledoc """
  Provides an interface into the Language service provided by Textgain.
  """

  # Define the module's struct.
  defstruct [:language, :confidence]

  # Module dependencies.
  require Logger

  # Module attributes.
  @service "language"

  @doc """
  Execute a request against the Language service.
  Returns a tuple containing one of:
  `
  {:ok, %Textgain.Language{}}
  {:error, msg}
  `
  """
  @spec query(text :: binary, options :: keyword) :: tuple(any, any)
  def query(text, options \\ []) do
    process_response(Textgain.query(@service, [q: text] ++ options))
  end

  @doc """
  Execute a request against the Language service.
  Same as `query/1` except an exception is thrown if an error occurs, otherwise it returns %Textgain.Language{}.
  """
  @spec query!(text :: binary, options :: keyword) :: %Textgain.Language{} | none
  def query!(text, options \\ []) do
    case process_response(query(text, options)) do
      {:ok, value} ->
        value
      {:error, msg} ->
        raise msg
      _ ->
        raise "Unknown error occurred"
    end
  end

  # Process successful query.
  defp process_response({:ok, body}) do
    {:ok, Poison.Decode.decode(body, as: %Textgain.Language{})}
  end

  # Process non-ok response.
  defp process_response(resp) do
    resp
  end
end
