

<<-LICENSE
The MIT License (MIT)
Copyright © 2015 Jeff Emminger <jeff@7compass.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
LICENSE

#TODO: PR our forked sentimental or embed it as a module on our app.

require_relative 'file_reader'

class Sentimental
  include FileReader

  attr_accessor :threshold, :word_scores, :neutral_regexps, :ngrams, :influencers

  def initialize(threshold: 0, word_scores: nil, neutral_regexps: [], ngrams: 1, influencers: nil)
    @ngrams = ngrams.to_i.abs if ngrams.to_i >= 1
    @word_scores = word_scores || {}
    @influencers = influencers || {}
    @word_scores.default = 0.0
    @influencers.default = 0.0
    @threshold = threshold
    @neutral_regexps = neutral_regexps
  end

  def score(string)
    return 0 if neutral_regexps.any? { |regexp| string =~ regexp }

    initial_scoring = {score: 0, current_influencer: 1.0}

    extract_words_with_n_grams(string).inject(initial_scoring) do |current_scoring, word|
      process_word(current_scoring, word)
    end[:score]
  end

  def sentiment(string)
    score = score(string)

    if score < (-1 * threshold)
      :negative
    elsif score > threshold
      :positive
    else
      :neutral
    end
  end

  def explain(string)
    # TODO: learn more about ruby method returns so we can modify this better
    return 0 if neutral_regexps.any? { |regexp| string =~ regexp }

    initial_scoring = {score: 0, current_influencer: 1.0, words: [],
                       influencers_seen: []}

    extract_words_with_n_grams(string).inject(initial_scoring) do |current_scoring, word|
      extract_word(current_scoring, word)
      # TODO: figure out how this method is returning stuff
    end[:words]
  end

  def classify(string)
    sentiment(string) == :positive
  end

  def load_defaults
    %w(slang en_words).each do |filename|
      load_from_json(File.dirname(__FILE__) + "/data/#{filename}.json")
    end
    load_influencers_from_json(File.dirname(__FILE__) + '/data/influencers.json')
  end

  def load_from(filename)
    load_to(filename, word_scores)
  end

  def load_influencers(filename)
    load_to(filename, influencers)
  end

  def load_to(filename, hash)
    hash.merge!(hash_from_txt(filename))
  end

  def load_from_json(filename)
    word_scores.merge!(hash_from_json(filename))
  end

  def load_influencers_from_json(filename)
    influencers.merge!(hash_from_json(filename))
  end

  alias load_senti_file load_from
  alias load_senti_json load_from_json

  alias_method :load_senti_file, :load_from

  private

  def extract_word(scoring, word)
    # TODO: don't do this, merge it into the function correctly. This is only a test.
    if influencers[word] > 0
      scoring[:current_influencer] *= influencers[word]
      scoring[:influencers_seen].push({ word: word, score: influencers[word] })
    else
      scoring[:score] += word_scores[word] * scoring[:current_influencer]
      scoring[:words].push({ word: word, score: word_scores[word] * scoring[:current_influencer],
                            is_influenced:  scoring[:current_influencer] != 1.0})
      scoring[:current_influencer] = 1.0
    end
    scoring
  end

  def process_word(scoring, word)
    if influencers[word] > 0
      scoring[:current_influencer] *= influencers[word]
    else
      scoring[:score] += word_scores[word] * scoring[:current_influencer]
      scoring[:current_influencer] = 1.0
    end
    scoring
  end

  def extract_words(string)
    string.to_s.downcase.scan(/([\w']+|\S{2,})/).flatten
  end

  def extract_words_with_n_grams(string)
    words = extract_words(string)
    (1..ngrams).to_a.map do |ngram_size|
      ngramify(words, ngram_size)
    end.flatten
  end

  def ngramify(words, max_size)
    return [words.join(' ')] if words.size <= max_size
    tail = words.last(words.size - 1)

    [words.first(max_size).join(' ')] + ngramify(tail, max_size)
  end

  def influence_score
    @total_score < 0.0 ? -@influence : +@influence
  end
end
