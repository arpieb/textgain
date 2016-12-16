# Textgain

The **Textgain** Elixir package provides a simple interface into the [Textgain](https://www.textgain.com/) web service for natural language processing (NLP) and text analytics.  The analytics services currently available are:
 
* Age
* Concepts
* Education
* Gender
* Genre
* Language
* Part-of-speech tags
* Personality
* Sentiment

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `textgain` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:textgain, "~> 0.1.0"}]
    end
    ```

  2. Ensure `textgain` is started before your application:

    ```elixir
    def application do
      [applications: [:textgain]]
    end
    ```

  3. Configure your API key, if you have one, in config.exs:
  
    ```elixir
    config :textgain,
      key: "***"
    ```

## Usage

The package is architected around the `Textgain` service module, which provides a raw query function as well as a macro expansion that allows for easily adding new services that themselves can have more complex processing.  Each service is wrapped in its own module:

* Textgain.Age
* Textgain.Concepts
* Textgain.Education
* Textgain.Gender
* Textgain.Genre
* Textgain.Language
* Textgain.Personality
* Textgain.Sentiment
* Textgain.Tags

To use the modules, simply call the ```query``` function in each, with the text to be analyzed as the first argument followed by a keyword list of optional parameters, per the [API services documentation](https://www.textgain.com/api).  Valid return values are also documented on the API services page.

```elixir
iex(1)> Textgain.Age.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Age{age: "25+", confidence: 0.75}}

iex(2)> Textgain.Concepts.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Concepts{concepts: ["jump", "fox", "dog"]}}

iex(3)> Textgain.Education.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Education{confidence: 0.8, education: "-"}}

iex(4)> Textgain.Gender.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Gender{confidence: 0.75, gender: "m"}}

iex(5)> Textgain.Genre.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Genre{confidence: 0.95, genre: "review", review: nil}}

iex(6)> Textgain.Language.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Language{confidence: 0.95, language: "en"}}

iex(7)> Textgain.Personality.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Personality{confidence: 0.6, personality: "E"}}

iex(8)> Textgain.Sentiment.query("The quick brown fox jumps over the lazy dog.")
{:ok, %Textgain.Sentiment{confidence: 0.7, polarity: 0.0}}

iex(9)> Textgain.Tags.query("The quick brown fox jumps over the lazy dog.")
{:ok,
 %Textgain.Tags{confidence: 0.95,
  text: [[[%{"tag" => "DET", "word" => "The"},
     %{"tag" => "ADJ", "word" => "quick"}, %{"tag" => "ADJ", "word" => "brown"},
     %{"tag" => "NOUN", "word" => "fox"},
     %{"tag" => "NOUN", "word" => "jumps"}],
    [%{"tag" => "PREP", "word" => "over"}],
    [%{"tag" => "DET", "word" => "the"}, %{"tag" => "ADJ", "word" => "lazy"},
     %{"tag" => "NOUN", "word" => "dog"}],
    [%{"tag" => "PUNC", "word" => "."}]]]}}
```
