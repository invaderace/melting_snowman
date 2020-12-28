require_relative 'dictionary'

class Game
  attr_accessor :turns_left, :word_display
  attr_reader :word, :word_array

  def initialize
    @word = Dictionary.new.rand_word
    @turns_left = 10
    @word_array = @word.split('')
    @word_display = word_display
  end

  def lose?
    true if turns_left == 0
  end

  def take_turn
    turns_left -= 1
  end

  def turn
    #guess
    #if the guess is in the word, show where.
    #if the guess isn't in the word, take_turn
    # tell them the game is over if lose? is true
  end

  def word_display
  end

  def word_display_setup
    word_array.map do |letter|
      letter = '_'
    end
  end

end
