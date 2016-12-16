defmodule TextgainTest do
  use ExUnit.Case
  doctest Textgain

  #
  # Values to use for various tests.
  #
  @test_text ~S"""
  Hi! We've just launched Textgain (https://textgain.com), an AI spin-off company from the University of Antwerp.
  """

  #
  # Successful query tests as the service will pretty much consume anything you throw at it.
  # Only way I've found to make a call fail is to butcher the endpoint, which is compiled in.
  #
  test "testing age service" do
    assert {:ok, %Textgain.Age{age: _age, confidence: _confidence}} = Textgain.Age.query(@test_text)
    assert %Textgain.Age{age: _age, confidence: _confidence} = Textgain.Age.query!(@test_text)
  end

  test "testing concepts service" do
    assert {:ok, %Textgain.Concepts{concepts: _concepts}} = Textgain.Concepts.query(@test_text)
    assert %Textgain.Concepts{concepts: _concepts} = Textgain.Concepts.query!(@test_text)
  end

  test "testing education service" do
    assert {:ok, %Textgain.Education{education: _education, confidence: _confidence}} = Textgain.Education.query(@test_text)
    assert %Textgain.Education{education: _education, confidence: _confidence} = Textgain.Education.query!(@test_text)
  end

  test "testing gender service" do
    assert {:ok, %Textgain.Gender{gender: _gender, confidence: _confidence}} = Textgain.Gender.query(@test_text)
    assert %Textgain.Gender{gender: _gender, confidence: _confidence} = Textgain.Gender.query!(@test_text)
  end

  test "testing genre service" do
    assert {:ok, %Textgain.Genre{genre: _genre, confidence: _confidence}} = Textgain.Genre.query(@test_text)
    assert %Textgain.Genre{genre: _genre, confidence: _confidence} = Textgain.Genre.query!(@test_text)
  end

  test "testing language service" do
    assert {:ok, %Textgain.Language{language: _language, confidence: _confidence}} = Textgain.Language.query(@test_text)
    assert %Textgain.Language{language: _language, confidence: _confidence} = Textgain.Language.query!(@test_text)
  end

  test "testing personality service" do
    assert {:ok, %Textgain.Personality{personality: _personality, confidence: _confidence}} = Textgain.Personality.query(@test_text)
    assert %Textgain.Personality{personality: _personality, confidence: _confidence} = Textgain.Personality.query!(@test_text)
  end

  test "testing POS tags service" do
    assert {:ok, %Textgain.Tags{text: _text, confidence: _confidence}} = Textgain.Tags.query(@test_text)
    assert %Textgain.Tags{text: _text, confidence: _confidence} = Textgain.Tags.query!(@test_text)
  end

  test "testing sentiment service" do
    assert {:ok, %Textgain.Sentiment{polarity: _polarity, confidence: _confidence}} = Textgain.Sentiment.query(@test_text)
    assert %Textgain.Sentiment{polarity: _polarity, confidence: _confidence} = Textgain.Sentiment.query!(@test_text)
  end
end
