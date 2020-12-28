require_relative 'dictionary'

class Game
  attr_reader :word

  def initialize
    @word = Dictionary.new.rand_word
  end
end
