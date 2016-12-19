defmodule Textgain do
  @moduledoc """
  This module provides access to the various text analytics services provided by [Textgain](https://www.textgain.com/).

  Each service is implemented as a function in this module, with both the tuple and "!" versions provided.
  """

  use Textgain.Service

  # Define our service endpoints and related structs.
  service :age, Textgain.Age
  service :concepts, Textgain.Concepts
  service :education, Textgain.Education
  service :gender, Textgain.Gender
  service :genre, Textgain.Genre
  service :language, Textgain.Language
  service :personality, Textgain.Personality
  service :sentiment, Textgain.Sentiment
  service :tag, Textgain.Tag
end
