defmodule Textgain do
  @moduledoc """
  This module provides the common entrypoints into the Textgain API used by
  the specific web service modules.
  """

  # Module dependencies.
  require Logger

  # Module attributes.
  @api_endpoint "https://api.textgain.com/1/"

  #
  # Shorthand config retrieval functions with reasonable defaults.
  # Why not use module attributes? Some deployments require runtime retrieval, attributes are compile-time.
  #
  defp key do
    Application.get_env(:textgain, :key, nil)
  end

  @doc """
  Execute a raw query against the Textgain service.
  """
  @spec query(service :: binary, params :: keyword(binary)) :: map
  def query(service, params) do
    params_w_key = add_key(params, key())
    Logger.debug("Executing query to service '#{@api_endpoint <> service}' with params: #{inspect_str(params_w_key)}")
    HTTPoison.get(@api_endpoint <> service, %{}, params: params_w_key)
    |> process_response(service, params)
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
  defp process_response({:ok, %HTTPoison.Response{body: body}}, _service, _params) do
    {:ok, body}
  end

  # Process error response.
  defp process_response({:error, err}, service, params) do
    # Extract params into something loggable, scrubbing API key.
    params_str = inspect_str(Keyword.delete(params, :key))
    msg = HTTPoison.Error.message(err)
    Logger.error("Failed on query to service '#{service}' with params: #{params_str}")
    {:error, msg}
  end

  # Inspect item, return as a binary.
  defp inspect_str(item) do
    {:ok, str_io} = StringIO.open("")
    IO.inspect(str_io, item)
    {_, {_, item_str}} = StringIO.close(str_io)
    item_str
  end

end
