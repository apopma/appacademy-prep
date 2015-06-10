class Code
  attr_accessor :cipher
  
  def initialize(code_string = nil)
    @cipher = parse_input(code_string)
    @@symbols = [:r, :g, :b, :y, :o, :p]
  end
  
  def parse_input(input)
    if input.is_a? String # when called normally
      input.split('').map { |char| char.downcase.to_sym }
    elsif input.is_a? Array #only when called from self.random
      input
    else
      raise TypeError, "#parse_input needs a string or array"
    end
  end
  
  def self.symbols
    [:r, :g, :b, :y, :o, :p]
  end
  
  def self.random
    Code.new(Code.symbols.sample(4))
  end
  
  
  def printable
    @cipher.map { |char| char.upcase.to_s }.join(", ")
  end
  
  
  def matches(other_code)
    matches = { exact: 0, partial: 0 }
    matches[:exact] = exact_matches(other_code)
    matches[:partial] = near_matches(other_code)
    matches
  end
  
  
  def exact_matches(other_code)
    cipher.select.with_index do |peg, idx|
      cipher[idx] == other_code.cipher[idx]
    end.length
  end
  
  
  def near_matches(other_code)
    other_cipher = other_code.cipher
    num_of_matches = 0

    #generates an array of this Code's cipher with exact matches missing
    cipher_without_exacts = cipher.reject.with_index do |peg, idx|
      cipher[idx] == other_cipher[idx]
    end
    
    #does the same for the other Code (i.e. a user's guess)
    other_cipher_without_exacts = other_cipher.reject.with_index do |peg, idx|
      other_cipher[idx] == cipher[idx]
    end
    
    #returns the number of characters in the other Code included in this Code
    cipher_without_exacts.each_with_index do |char, idx|
      if other_cipher_without_exacts.include?(char)
        num_of_matches += 1
        cipher_without_exacts[idx] = '-'
        other_cipher_without_exacts[ other_cipher_without_exacts.index(char) ] = '-'
        #above .index(char) statement returns the first index char is found at
      end
    end
    num_of_matches
  end
end

# -----------------------------------------------------------------------------

class Game
  attr_reader :secret_code
  attr_accessor :turn, :user_guess
  
  def initialize
    @guesses_left = 10
    @secret_code = Code.random
    @user_guess = nil
  end
  
  def victory?
    @user_guess.cipher == @secret_code.cipher
  end
  
  def failure?
    @guesses_left == 0
  end
  
  def play
    #puts "The secret code is #{@secret_code.cipher} (shh)"
    
    while @guesses_left > 0
      puts "You have #{@guesses_left} guesses remaining."
      print "Enter a new guess: (4 letters from the set RGBYOP) "
      guess = gets.chomp
      
      until valid_guess?(guess)
        puts "Your guess needs to be 4 letters from the set RGBYOP."
        print "Please try again: "
        guess = gets.chomp
      end
      
      @guesses_left -= 1
      @user_guess = Code.new(guess)
      break if victory?
      
      user_matches = @secret_code.matches(user_guess)
      puts "#{@user_guess.printable} had #{user_matches[:exact]} exact matches and #{user_matches[:partial]} partial matches"
    end
    
    
    if victory?
      puts "Hurrah! You guessed the secret code in #{10 - @guesses_left} tries."
    elsif failure?
      puts "Woe unto you! You couldn't guess the secret code - #{@secret_code.printable}."
    end
  end
  
  
  def valid_guess?(guess)
    guess.length == 4 && guess.split("").all? { |char| Code::symbols.include?(char.to_sym) }
  end
  
end

# =============================================================================

def invoke
  puts "Welcome to Mastermind!"
  Game.new.play
end



invoke if __FILE__ == $PROGRAM_NAME