defmodule Textgain do
  @moduledoc """
  This module provides the common entrypoints into the Textgain API used by
  the specific web service modules.
  """

  # Module dependencies.
  require Logger

  # Module attributes.
  @api_endpoint "https://api.textgain.com/1/"

  defmacro __using__(opts) do
    service = opts[:service]
    quote do
      import unquote(__MODULE__)

      @doc """
      Executes a query against the Textgain `#{unquote(service)}` service, returning one of two tuples:

      ```
      { :ok, %{} }
      { :error, msg }
      ```

      See the [Textgain API services](https://www.textgain.com/api) page for details on returned analytics.
      """
      @spec query(text :: binary, options :: keyword) :: tuple
      def query(text, options \\ []) do
        process_response(Textgain.raw_query(unquote(service), [q: text] ++ options))
      end

      @doc """
      Executes a query against the Textgain `#{unquote(service)}` service, returning a valid
      struct or raising an exception.

      See the [Textgain API services](https://www.textgain.com/api) page for details on returned analytics.
      """
      @spec query!(text :: binary, options :: keyword) :: %__MODULE__{} | none
      def query!(text, options \\ []) do
        case query(text, options) do
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

  # Shorthand config retrieval functions fro Textgain API key.
  # Why not use module attributes? Some deployments require runtime retrieval, attributes are compile-time.
  defp key do
    Application.get_env(:textgain, :key, nil)
  end

  @doc """
  Execute a raw query against the Textgain service.

  This function is called providing the `service` endpoint name and a keyword list of parameters.

  Note that the `q` parameter is always used to pass the text to be analyzed by the web service, and is
  limited to 3000 characters.
  """
  @spec raw_query(service :: binary, params :: keyword(binary)) :: map
  def raw_query(service, params) do
    params_w_key = add_key(params, key())
    #Logger.debug("Executing query to service '#{@api_endpoint <> service}' with params: #{inspect_str(params_w_key)}")
    HTTPoison.get(@api_endpoint <> service, %{}, params: params_w_key)
    |> service_process_response(service, params)
  end

  # Add key if provided via config, else leave unset for freebie API call.
  defp add_key(params, nil) do
    params
  end

  defp add_key(params, key) do
    # Using Keyword.put_new/3 leaves a key:val tuple alone if it already exists.
    Keyword.put_new(params, :key, key)
  end

  # Process successful response.
  defp service_process_response({:ok, %HTTPoison.Response{body: body}}, _service, _params) do
    {:ok, body}
  end

  # Process error response.
  defp service_process_response({:error, err}, service, params) do
    # Extract params into something loggable, scrubbing API key.
    params_str = inspect_str(Keyword.delete(params, :key))
    msg = HTTPoison.Error.message(err)
    Logger.error("Failed on query to service '#{service}' with params: #{params_str}")
    {:error, msg}
  end

  # Inspect item, return as a binary.
  defp inspect_str(item) do
    {:ok, str_io} = StringIO.open("")
    IO.inspect(str_io, item, width: 0)
    {_, {_, item_str}} = StringIO.close(str_io)
    item_str
  end

end
