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
  
  def congratulations
    "Congratulations, you've saved the snowman this time!"
  end

  def game_over
    'Sorry, looks like the snowman has melted. Game over.'
  end

  def guess_correct?
    true if word_array.include? guess
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
    true if @turns_left == 0
  end

  def take_turns
    turn
    puts turns_left
    if win?
      puts congratulations
      return
    elsif lose?
      puts game_over
      return
    else
      take_turns
    end
    # tell them the game is over if lose? is true
  end

  def turn
    #guess
    guess_enter
    #if the guess is in the word, show where.
    if guess_correct?
      word_display_update
    else
    #if the guess isn't in the word, take_turn
      @turns_left -= 1
    end
    puts word_display
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
    word_array.map do |letter|
      letter = '_'
    end
  end

  def word_display_update
    word_array.each do |i|
      #compare the guess with each spot in the original word. 
      #if it's the same, update in the same index.
      if i == guess
        word_display_array[word_array.index(i)] = i
      end
    end
  end
end
