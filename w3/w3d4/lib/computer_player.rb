class ComputerPlayer
  attr_accessor :secret_word, :secret_length, :guesses
  attr_reader :dictionary
  
  def initialize
    @dictionary = File.readlines("lib/dictionary.txt")
    @dictionary.map! {|word| word.chomp}
    @secret_word = dictionary.sample
    @secret_length = pick_secret_word
    @guesses = []
  end
  
  
  def pick_secret_word
    # For a computer, picks a random dictionary line and returns its length.
    secret_word.length
  end
  
  
  def get_secret_length(human_length)
    # Gets the secret length from the player.
    # Also filters the dictionary to only words of that length.
    @secret_length = human_length
    filter_by_length
  end
  
  
  def handle_guess_response(human_guess)
    # Recieves a human's guessed letter
    # and returns an array of indices that letter is present at.
    guess_locations = []
    word_array = secret_word.split('')
    
    #puts "the secret word is #{secret_word} (shh)"
    word_array.each_with_index do |char, idx|
      guess_locations << idx if word_array[idx] == human_guess
    end
    guess_locations
  end
  
  
  def won?(guess)
    @secret_word == guess
  end
  
  
  def filter_by_length
    # Filters the dictionary to words of the right length.
    dictionary.select! {|word| word.length == secret_length }
  end
  
  
  def filter_by_letters(char, positions)
    # Filters the dictionary to only those words
    # containing char at the positions specified.
    
    dictionary.reject! { |word| word.include?(char) } if positions.empty?
    dictionary.select! { |word| right_positions?(word, char, positions) }
  end
  
  
  def right_positions?(word, char, positions)
    positions.all? { |position| word[position] == char }
  end
  
  
  def guess
    # Builds a frequency hash out of the dictionary.
    # Returns the most common letter, unless it guessed that already.
    # If it did, pick the most common un-guessed letter.
    # If only one word is left in the dictionary, 
    # pick that word's first un-guessed letter.
    
    letter_freqs = Hash.new(0)
    
    dictionary.each do |word|
      word.split('').each do |letter|
        letter_freqs[letter] += 1
      end
    end
  
    #p letter_freqs
    most_common_letter = letter_freqs.key(letter_freqs.values.max)
    
    unless guesses.include?(most_common_letter)
      guesses << most_common_letter
      return most_common_letter 
    end
    
    if guesses.include?(most_common_letter) && dictionary.size == 1
      # ensures the computer guesses other letters in the only word left
      dictionary.first.split('').each do |char|
        unless guesses.include?(char)
          guesses << char
          return char
        end
      end
      
    elsif guesses.include?(most_common_letter)
      unguessed_letters = letter_freqs.reject do |letter|
        guesses.include?(letter)
      end
      
      next_most_common = unguessed_letters.key(unguessed_letters.values.max)
      guesses << next_most_common
      return next_most_common
    end
    raise "cain" #should never reach this line
  end
end