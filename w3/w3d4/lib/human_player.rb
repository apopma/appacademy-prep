class HumanPlayer
  attr_reader :secret_length, :guess
  
  INPUT_REGEX = /^[a-z]$/
  GUESS_CHECKING_REGEX = /([0-9]+[0-9]*)/
  
  def initialize
    @secret_length = nil
    @guess = ''
  end
  
  def pick_secret_word
    # For a human, just write it down. Give it the length.
    word_length = nil
    puts "Enter your secret word length: "
    word_length = gets.chomp.to_i
    word_length
  end
  
  def get_secret_length(length)
    secret_length = length
    puts "The secret word is #{secret_length} letters long."
  end

  
  def guess
    # can't sanity test with an until loop, stack level too deep
      print "What's your guess? (one character only) > "
      human_guess = gets.chomp.downcase
      puts "I didn't understand that. Too bad!" unless human_guess =~ INPUT_REGEX
    human_guess
  end
  
  
  def handle_guess_response(computer_guess)
    # Relies on the user being honest
    puts "The computer guesses #{computer_guess.upcase}."
    puts "What positions does this letter occur at?"
    puts "Enter all of them, separated by spaces."
    puts "(Just hit Enter if the answer is 'none of them'.)"
    print "> "
    guess_locations = gets.chomp.scan(GUESS_CHECKING_REGEX).flatten
    guess_locations.map! { |x| (x.to_i) - 1 }
  end
  
  
  def won?(guess)
    # gets passed the current partial
    if guess.split('').none? {|char| char == '_' }
      print "Is the answer '#{guess}'? (y/n) > "
      gets.chomp.downcase == "y" ? true : false
    end
  end
  
  
  def filter_by_letters(useless, args)
    # only relevant for a ComputerPlayer,
    # but the Hangman class shouldn't care what Player it gets
  end
end