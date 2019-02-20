# Textgain

[![Build Status](https://travis-ci.org/arpieb/textgain.svg?branch=master)](https://travis-ci.org/arpieb/textgain)
[![Hex.pm](https://img.shields.io/hexpm/v/textgain.svg)](https://hex.pm/packages/textgain)

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

If [available in Hex](https://hex.pm/packages/textgain), the package can be installed as:

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

**Note:** Without an API key you are restricted to 100 API calls in a 24 hour period, and some API calls might be refused.  That being said, some of your tests will fail if you are not using a legit API key.

## Usage

The package's main API module is `Textgain` which leverages the `service` macro defined in `Textgain.Service` to instantiate endpoints for each Textgain service.  All returned data is decoded into service-specific structs to facilitate leveraging Elixir's pattern matching to process responses.

Additionally, the `Textgain.Service` module exposes a public function `raw_query` which can be used to execute custom queries against the service if necessary.

To use the module, simply call the service by function name in the `Textgain` module, with the text to be analyzed as the first argument followed by a keyword list of optional parameters, per the [API services documentation](https://www.textgain.com/api).  Valid return values are also documented on the API services page.

```elixir
iex(1)> Textgain.age("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Age{age: "25+", confidence: 0.75}}

iex(2)> Textgain.concepts("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Concepts{concepts: ["jump", "fox", "dog"]}}

iex(3)> Textgain.education("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Education{confidence: 0.8, education: "-"}}

iex(4)> Textgain.gender("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Gender{confidence: 0.75, gender: "m"}}

iex(5)> Textgain.genre("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Genre{confidence: 0.95, genre: "review", review: nil}}

iex(6)> Textgain.language("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Language{confidence: 0.95, language: "en"}}

iex(7)> Textgain.personality("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Personality{confidence: 0.6, personality: "E"}}

iex(8)> Textgain.sentiment("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok, %Textgain.Sentiment{confidence: 0.7, polarity: 0.0}}

iex(9)> Textgain.tag("The quick brown fox jumps over the lazy dog.", lang: "en")
{:ok,
 %Textgain.Tag{confidence: 0.95,
  text: [[[%{"tag" => "DET", "word" => "The"},
     %{"tag" => "ADJ", "word" => "quick"}, %{"tag" => "ADJ", "word" => "brown"},
     %{"tag" => "NOUN", "word" => "fox"},
     %{"tag" => "NOUN", "word" => "jumps"}],
    [%{"tag" => "PREP", "word" => "over"}],
    [%{"tag" => "DET", "word" => "the"}, %{"tag" => "ADJ", "word" => "lazy"},
     %{"tag" => "NOUN", "word" => "dog"}],
    [%{"tag" => "PUNC", "word" => "."}]]]}}
```

The "!" variant for each function also exists, which will return just the service struct or raise an error.
