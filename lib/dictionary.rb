# frozen_string_literal: true

# Opens the .txt file and stores to array. Picks a random word for the Game.
class Dictionary
  def initialize
    @dictionary_file = '5desk.txt'
    @dictionary = File.readlines @dictionary_file
  end

  def total_words
    @dictionary.index(@dictionary[-1])
  end

  def rand_word
    rand_index = rand(total_words + 1)
    @dictionary.each_with_index do |word, index|
      return word.chomp if index == rand_index
    end
  end
end
