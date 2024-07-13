# frozen_string_literal: true

class MapIndexesToWords
  attr_accessor :string, :words
  LEAVE_SYMBOLS = /[A-Za-z0-9]/

  def initialize(string: _string, words: _words)
    @string = string
    @words = words
  end

  def process
    result_hash = {}
    words.each do |word|
      result_hash[word] = return_all_indexes_of_word(word)
    end
    result_hash
  end

  private

  def word?(word, index)
    !string[index - 1].match?(LEAVE_SYMBOLS) && !string[index + word.length].match?(LEAVE_SYMBOLS)
  end

  def return_all_indexes_of_word(word)
    indexes = []
    string.enum_for(:scan, /(?=#{word})/).each do
      index = Regexp.last_match.offset(0).first
      indexes << index if word?(word, index)
    end
    indexes
  end
end
