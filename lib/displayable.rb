# frozen_string_literal: true

# Contains methods for diplaying and formatting the game title, snowman, and text.
module Displayable
  def clearscreen
    system 'clear'
  end

  def display_menu
    clearscreen
    display_header
    display_snowman
  end

  def display_game
    clearscreen
    display_header
    display_snowman
  end

  def display_header
    4.times { puts }
    puts '---------------------------------------'.center(width)
    puts 'Snowman'.center(width)
    puts '---------------------------------------'.center(width)
    4.times { puts }
  end

  def display_snowman
    snowman.each do |line|
      puts line.center(width)
    end
    puts
  end

  def display_text(input)
    puts input.center(width)
  end

  def width
    80
  end
end
