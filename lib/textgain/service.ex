defmodule Textgain.Service do
  @moduledoc """
  This module provides the common entrypoints into the Textgain API used by
  the specific web service modules.
  """

  # Module dependencies.
  require Logger

  # Module attributes.
  @api_endpoint "https://api.textgain.com/1/"

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @doc """
  Provides a mechanism to add Textgain services to the main `Textgain` module.

  The macro is used in the following way:

  ```elixir
  service :age, TextGain.Age
  ```

  Where the first parameter is the atom for the service name, and the second is the struct to cast the JSON to on
  decode.
  """
  @spec service(name :: atom, module :: atom) :: none
  defmacro service(name, module) do
    quote do
      @doc """
      Executes a query against the Textgain `#{Atom.to_string(unquote(name))}` service, returning one of two tuples:

      ```
      { :ok, %#{unquote(module)}{} }
      { :error, msg }
      ```

      See the [Textgain API services](https://www.textgain.com/api) page for details on returned analytics.
      """
      @spec unquote(name)(text :: binary, options :: keyword) :: tuple
      def unquote(name)(text, options \\ []) do
        case raw_query(Atom.to_string(unquote(name)), [q: text] ++ options) do
          {:ok, resp} ->
            Poison.decode(resp, as: %unquote(module){})
          other ->
            other
        end
      end

      @doc """
      Executes a query against the Textgain `#{Atom.to_string(unquote(name))}` service, returning a valid
      struct or raising an exception.

      See the [Textgain API services](https://www.textgain.com/api) page for details on returned analytics.
      """
      @spec unquote(:"#{name}!")(text :: binary, options :: keyword) :: %unquote(module){}
      def unquote(:"#{name}!")(text, options \\ []) do
        case unquote(name)(text, options) do
          {:ok, value} ->
            value
          {:error, msg} ->
            raise msg
          _ ->
            raise "Unknown error occurred"
        end
      end
    end
  end

  # Shorthand config retrieval functions for Textgain API key.
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
    HTTPoison.post(@api_endpoint <> service, "", %{}, params: params_w_key)
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
