defmodule Textgain.Service do
  @moduledoc """
  Provides a base for building Textgain REST service modules.
  """

  # Module dependencies.
  require Logger

  defmacro __using__(opts) do
    service = opts[:name]
    quote do
      import unquote(__MODULE__)
      @spec query(text :: binary, options :: keyword) :: tuple
      def query(text, options \\ []) do
        process_response(Textgain.query(unquote(service), [q: text] ++ options))
      end

      @spec query!(text :: binary, options :: keyword) :: %__MODULE__{} | none
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
        {:ok, Poison.decode!(body, as: %__MODULE__{})}
      end

      # Process non-ok response.
      defp process_response(resp) do
        resp
      end

    end
  end

end
