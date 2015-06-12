class Hangman
  attr_reader :dictionary, :secret
  attr_accessor :partial, :guess
  
  def initialize
    @dictionary = File.readlines("lib/dictionary.txt")
    @secret = get_random_word
    @partial = "_" * secret.length
    @guess = nil
  end
  
  def play
    puts "the secret word is #{secret} (shh)"
    
    until won?
      puts "Secret word: #{partial}"
      print "> "
      guess = gets.chomp
      secret.split('').map.with_index do |letter, idx|
        partial[idx] = letter if letter == guess
      end
    end
  end
  
  def won?
    partial == secret
  end
  
  
  def get_random_word
    dictionary.sample.chomp
  end

end

Hangman.new.play