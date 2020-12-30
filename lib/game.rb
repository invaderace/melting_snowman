# frozen_string_literal: true

require_relative 'dictionary'
require 'yaml'
require 'pry'

# Holds everything in the game.
class Game
  attr_accessor :guess, :word_display_array
  attr_reader :word, :word_array

  def initialize
    @word = Dictionary.new.rand_word
    @turns_left = 10
    @guess = ''
    @letters_used = []
    @word_array = @word.split('')
    @word_display_array = word_display_setup
  end

  def alphabet
    ('a'..'z').to_a
  end

  def congratulations
    "Congratulations, you've saved the snowman this time!"
  end

  def game_over
    'Sorry, looks like the snowman has melted. Game over.'
  end

  def guess_correct?
    true if (word_array.include? guess) || (word_array.include? guess.upcase)
  end

  def guess_enter
    # guess is gets.chomp, so ask for the entry
    puts guess_prompt
    @guess = gets.chomp.downcase
    # need to check if valid, if not, ask again.
    return if guess_valid?
    save?
    
    puts 'Invalid guess. Please try again.'
    guess_enter
  end

  def guess_prompt
    "Please guess a letter from a-z. Enter 'save' to save game and quit."
  end

  def guess_valid?
    true if (alphabet.include? guess)
  end

  def letters_used_display
    'Letters used: ' + @letters_used.join(' ') + '.'
  end

  # def load
  #   filename = 'save/savegame.yaml'
  #   save_file = File.open(filename, 'r')
  #   savegame = YAML::load(save_file)
  #   save_file.close
  #   savegame
  # end

  def lose?
    true if @turns_left.zero?
  end

  def save?
    if guess.downcase == 'save'
      save
      exit
    end
  end

  def save
    filename = 'save/savegame.yaml'
    save_file = File.open(filename, 'w')
    savegame = YAML::dump(self)
    save_file.puts savegame
    save_file.close
  end

  def take_turns
    puts word_display
    turn
    puts turns_left
    if win?
      puts congratulations
    elsif lose?
      puts game_over
    else
      take_turns
    end
  end

  def turn
    # guess
    guess_enter
    # if the guess is in the word, show where.
    if guess_correct?
      word_display_update
    else
      # if the guess isn't in the word, take_turn.
      @turns_left -= 1
    end
    @letters_used.push(@guess)
    puts letters_used_display
  end

  def turns_left
    'Turns left: ' + @turns_left.to_s
  end

  def win?
    true if word_array == word_display_array
  end

  def word_display
    word_display_array.join(' ')
  end

  def word_display_setup
    word_array.map do
      '_'
    end
  end

  def word_display_update
    word_array.each_with_index do |letter, index|
      # compare the guess with each spot in the original word.
      # if it's the same, update in the same index.
      word_display_array[index] = letter if letter.downcase == guess
    end
  end
end
