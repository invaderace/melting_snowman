require_relative 'dictionary'

class Game
  attr_accessor :guess, :turns_left, :word_display_array
  attr_reader :word, :word_array

  def initialize
    @word = Dictionary.new.rand_word
    @turns_left = 10
    @guess = ''
    @word_array = @word.split('')
    @word_display_array = word_display_setup
  end
  
  def alphabet
    ('a'..'z').to_a
  end

  def guess_enter
    # guess is gets.chomp, so ask for the entry
    puts guess_prompt
    @guess = gets.chomp.downcase
    # need to check if valid, if not, ask again. 
    unless guess_valid?
      puts 'Invalid guess. Please try again.'
      guess_enter
    end
  end

  def guess_prompt
    'Please guess a letter from a-z.'
  end

  def guess_valid?
    true if alphabet.include? guess
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
    word_display_array.join(' ')
  end

  def word_display_setup
    word_array.map do |letter|
      letter = '_'
    end
  end

end
