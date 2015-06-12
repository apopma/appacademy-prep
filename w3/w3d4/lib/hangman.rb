require_relative "human_player.rb"        # aA pair project: w3d4
require_relative "computer_player.rb"     # Adam Popma - Jonathan Elofson

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
    guessing_player.get_secret_length(secret_length)
    partial = '_' * secret_length
    guess = ""
    number_of_guesses = 0
    
    until number_of_guesses >= 10
      puts "The guess so far is: #{partial}"
      puts "#{10 - number_of_guesses} tries left."
      
      guess = guessing_player.guess
      answer = checking_player.handle_guess_response(guess)
      guessing_player.filter_by_letters(guess, answer)
      
      answer.each do |idx|
        partial[idx] = guess
      end
      
      number_of_guesses += 1
      break if partial.split('').none? {|letter| letter == "_" }
    end
    
    won?(partial) ? (puts "Hooray, you win!") : (puts "Sorry, you lost.")
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

# ========================================================================

def invoke
  gametype = 0
  
  puts "Welcome to Hangman!\n-------------------\n"
  until gametype.between?(1, 2)
    puts "Enter 1 to be the guesser."
    print "Enter 2 to play against the computer. > "
    gametype = gets.chomp.to_i
    puts "Sorry, please enter 1 or 2." unless gametype.between?(1, 2)
  end
  
  if gametype == 1
    Hangman.new(HumanPlayer.new, ComputerPlayer.new).play
  elsif gametype == 2
    Hangman.new(ComputerPlayer.new, HumanPlayer.new).play
  end
end


invoke if __FILE__ == $PROGRAM_NAME