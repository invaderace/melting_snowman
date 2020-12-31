# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'displayable'
require 'yaml'

# Holds everything in the game.
class Game
  include Displayable

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

  def current_snowman
    snowman_hash[@turns_left]
  end

  def display_game_details
    display_top
    display_text(guess_prompt)
    display_text(turns_left)
    @letters_used != [] ? display_text(letters_used_display) : puts
    display_text(word_display)
    display_result if win? || lose?
  end

  def display_result
    display_text(congratulations) if win?
    display_text(word_array.join(' ')) if lose?
    display_text(game_over) if lose?
    exit
  end

  def display_top
    display_refresh
    display_snowman(current_snowman)
  end

  def guess_correct?
    true if (word_array.include? guess) || (word_array.include? guess.upcase)
  end

  def guess_enter
    @guess = gets.chomp.downcase
    # check that the guess is a letter.
    return if guess_valid?

    # make sure if they entered 'save' before assuming the guess is invalid.
    save if save?
    puts 'Invalid guess. Please try again.'
    guess_enter
  end

  def guess_valid?
    true if alphabet.include? guess
  end

  def letters_used_display
    'Letters used: ' + @letters_used.join(' ') + '.'
  end

  def lose?
    true if @turns_left.zero?
  end

  def save?
    true if guess.downcase == 'save'
  end

  def save
    filename = 'save/savegame.yaml'
    save_file = File.open(filename, 'w')
    savegame = YAML.dump(self)
    save_file.puts savegame
    save_file.close
    exit
  end

  def take_turns
    turn
    display_game_details
    take_turns unless win? || lose?
  end

  def turn
    guess_enter
    guess_correct? ? word_display_update : @turns_left -= 1
    @letters_used.push(@guess)
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
    word_array.map { '_' }
  end

  def word_display_update
    word_array.each_with_index do |letter, index|
      # compare the guess with each spot in the original word. update if same.
      word_display_array[index] = letter if letter.downcase == guess
    end
  end
end
