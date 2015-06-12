class ComputerPlayer
  attr_accessor :secret_word, :secret_length
  attr_reader :dictionary
  
  
  def initialize
    @secret_word = File.readlines("lib/dictionary.txt").sample.chomp
    @secret_length = pick_secret_word
  end
  
  def pick_secret_word
    # For a computer, picks a random dictionary line and returns its length.
    secret_word.length
  end
  
  def get_secret_length(human_length)
    # Gets the secret length from the player.
    secret_length = human_length
  end
  
  def guess
    # guesses a random letter. will be better
      ('a'..'z').to_a.sample
  end
  
  def handle_guess_response(human_guess)
    guess_locations = []
    word_array = secret_word.split('')
    
    puts "the secret word is #{secret_word} (shh)"
    puts "the human guessed #{human_guess}"
    
   word_array.each_with_index do |char, idx|
      guess_locations << idx if word_array[idx] == human_guess
    end
    
    guess_locations
  end
  
  def won?(guess)
    @secret_word == guess
  end
  
end