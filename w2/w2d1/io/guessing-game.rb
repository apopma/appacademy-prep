class GuessingGame
  attr_reader :secret
  attr_accessor :guess, :number_of_guesses
  
  def initialize
    @secret = rand(1..100)
    @guess = 9001
    @number_of_guesses = 0
  end
  
  
  def play
    puts "Welcome to Guessing Numbers Game 9001!"
    puts "I'm thinking of a number between 1 and 100."
    print "Please enter a number: "
    
    while guess != secret
      @guess = gets.chomp.to_i
      check_guess
      @number_of_guesses += 1
    end
    
    puts "Congratulations! You made #{@number_of_guesses} guesses."
  end
  
  
  def check_guess
    if @guess > @secret
      print "#{@guess} is too big. Please guess again: "
    elsif @guess < @secret
      print "#{@guess} isn't big enough. Please guess again: "
    else
      puts "#{@secret} is the secret number!"
    end
  end
end

GuessingGame.new.play if __FILE__ == $PROGRAM_NAME  