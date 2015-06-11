require 'byebug'
require_relative 'board.rb'
require_relative 'human_player.rb'

class BattleshipGame
  attr_reader :battlefield
  
  def initialize
    @battlefield = Board.new
  end
  
  
  def play
    puts "Welcome to Battleship!"
    
    until game_over?
      puts "\nThere are #{ships_afloat} ships remaining."
      battlefield.display
      move
    end
    
    if ships_afloat == 0
      puts "Victory at sea! The enemy navy is on its way to Davy Jones' Locker."
      puts "Congratulations!"
    else
      puts "Ignominious defeat! The enemy's #{ships_afloat} remaining vessels take you into custody."
      puts "Your court-martial is scheduled for next Tuesday."
    end
  end
  
  
  def move
    input = nil
    input_format = /^[0-9]\s[0-9]$/  # like this: "2 2" or "0 6"
    
    until input =~ input_format
      print "Enter a row and column 0 thru 9 to fire at, separated by a space: "
      input = gets.chomp
      puts "Sorry, I didn't understand that." unless input =~ input_format
    end
    
    input = input.split(" ").map { |coord| coord.to_i }
    battlefield.fire_on(input)
  end
  
  
  def game_over?
    battlefield.full? || ships_afloat == 0
  end
  
  def ships_afloat
    battlefield.count_ships
  end
  
end

BattleshipGame.new.play if __FILE__ == $PROGRAM_NAME