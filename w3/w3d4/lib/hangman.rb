require_relative "human_player.rb"
require_relative "computer_player.rb"
require 'byebug'

class Hangman
  attr_reader :dictionary, :secret_length,
              :guessing_player, :checking_player
  attr_accessor :partial
  
  def initialize(guessing_player, checking_player)
    @dictionary = File.readlines("lib/dictionary.txt")
    @guessing_player = guessing_player
    @checking_player = checking_player
    @secret_length = checking_player.pick_secret_word
    @partial = ""
  end
  
  def play
    puts "Picked secret word"
    guessing_player.get_secret_length(secret_length)
    puts "Got secret length"
    partial = '_' * secret_length
    guess = ""
    
    
    until won?(partial)
      puts "The partial so far is: #{partial}"
      
      guess = guessing_player.guess
      answer = checking_player.handle_guess_response(guess)
      
      answer.each do |idx|
        partial[idx] = guess
      end
    end
    
    puts "Winner!"
  end
  
  def valid_input?(char)
    char.length == 1 && (a..z).to_a.include?(char)
  end
  
  def won?(guess)
    checking_player.won?(guess)
  end
  
  
  def get_random_word
    dictionary.sample.chomp
  end

end

def invoke
  Hangman.new(ComputerPlayer.new, HumanPlayer.new).play
end


invoke if __FILE__ == $PROGRAM_NAME