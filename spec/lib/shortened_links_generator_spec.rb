# frozen_string_literal: true

require 'rails_helper'
require 'shortened_links_generator'

EXAMPLE_STRING = 'ExampleString'

RSpec.describe ShortenedLinksGenerator do
  it 'generates valid, 3 word long shortened link for given string' do
    short = ShortenedLinksGenerator.shorten(EXAMPLE_STRING)
    expect(short).to match(/^\w+-\w+-\w+/)
  end

  it 'generates same link for same string' do
    short1 = ShortenedLinksGenerator.shorten(EXAMPLE_STRING)
    short2 = ShortenedLinksGenerator.shorten(EXAMPLE_STRING)

    expect(short1).to eq(short2)
  end

  it 'raises ArgumentError when passed < 1 number of adjectives' do
    expect do
      ShortenedLinksGenerator
        .shorten(EXAMPLE_STRING, -1)
    end    .to raise_error(ArgumentError)
  end

  it 'raises ArgumentError when passed < 1 number of animals' do
    expect do
      ShortenedLinksGenerator
        .shorten(EXAMPLE_STRING, 2, 0)
    end .to raise_error(ArgumentError)
  end
end
