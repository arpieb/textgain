defmodule Textgain.Genre do
  @moduledoc """
  Provides an interface into the Genre service provided by Textgain.
  """

  # Define the module's struct.
  defstruct [:genre, :review, :confidence]

  # Module dependencies.
  require Logger

  # Module attributes.
  @service "genre"

  @doc """
  Execute a request against the Genre service.
  Returns a tuple containing one of:
  `
  {:ok, %Textgain.Genre{}}
  {:error, msg}
  `
  """
  @spec query(text :: binary) :: tuple
  def query(text) do
    process_response(Textgain.query(@service, [q: text]))
  end

  @doc """
  Execute a request against the Language service.
  Same as `query/1` except an exception is thrown if an error occurs, otherwise it returns %Textgain.Language{}.
  """
  @spec query!(text :: binary) :: %Textgain.Genre{} | none
  def query!(text) do
    case process_response(Textgain.query(@service, [q: text])) do
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
    {:ok, Poison.Decode.decode(body, as: %Textgain.Genre{})}
  end

  # Process non-ok response.
  defp process_response(resp) do
    resp
  end
end
