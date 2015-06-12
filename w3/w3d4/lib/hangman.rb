class Hangman
  attr_reader :dictionary, :secret
  attr_accessor :partial, :guess
  INPUT_REGEX = /^[a-z]$/
  
  def initialize
    @dictionary = File.readlines("lib/dictionary.txt")
    @secret = get_random_word
    @partial = "_" * secret.length
    @guess = ''
  end
  
  def play
    puts "the secret word is #{secret} (shh)"
    
    until won?
      puts "Secret word: #{partial}"
      
      until guess =~ INPUT_REGEX
        print "> "
        guess = gets.chomp.downcase
        puts "Sorry, I didn't understand that." unless guess =~ INPUT_REGEX
        break if guess =~ INPUT_REGEX
      end
      
      secret.split('').map.with_index do |letter, idx|
        partial[idx] = letter if letter == guess
      end
    end
    
    puts "Winner!"
      
  end
  
  def valid_input?(char)
    char.length == 1 && (a..z).to_a.include?(char)
  end
  
  def won?
    partial == secret
  end
  
  
  def get_random_word
    dictionary.sample.chomp
  end

end

Hangman.new.play