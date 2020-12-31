# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'displayable'
require 'yaml'
require 'pry'

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

  def congratulations
    "Congratulations, you've saved the snowman this time!"
  end
  
  def current_snowman
    case @turns_left
    when 10
      snowman_ten
    when 9
      snowman_nine
    when 8
      snowman_eight
    when 7
      snowman_seven
    when 6
      snowman_six
    when 5
      snowman_five
    when 4
      snowman_four
    when 3
      snowman_three
    when 2
      snowman_two
    when 1
      snowman_one
    else
      snowman_zero
    end
  end

  def display_win
    display_game
    display_snowman(current_snowman)
    3.times { puts }
    display_text(word_display)
    display_text(congratulations)
  end

  def display_lose
    display_game
    display_snowman(current_snowman)
    puts
    display_text(turns_left)
    display_text(letters_used_display)
    display_text(word_display)
    display_text(word_array.join(' '))
    display_text(game_over)
  end

  def game_over
    'Sorry, looks like the snowman has melted. Game over.'
  end

  def guess_correct?
    true if (word_array.include? guess) || (word_array.include? guess.upcase)
  end

  def guess_enter
    # guess is gets.chomp, so ask for the entry
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
    true if alphabet.include? guess
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
    return unless guess.downcase == 'save'

    save
    exit
  end

  def save
    filename = 'save/savegame.yaml'
    save_file = File.open(filename, 'w')
    savegame = YAML.dump(self)
    save_file.puts savegame
    save_file.close
  end

  def take_turns
    display_game
    display_snowman(current_snowman)
    display_text(guess_prompt)
    display_text(turns_left)
    @letters_used != [] ? display_text(letters_used_display) : puts
    display_text(word_display)
    turn
    if win?
      display_win
    elsif lose?
      display_lose
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
