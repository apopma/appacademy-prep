class Fixnum                      # aA pair project: w1d4
  def in_words                    # Adam Popma - Connor Stauffer
    
    return "zero" if self == 0
    $ranges = [ "", "thousand", "million", "billion", "trillion"]
    
    def run
      # Builds the final string largest-to-smallest 3 digits at a time
      # Matches digits in a lookup, and appends from $ranges to the match
      # Does not handle quadrillions and above
      
      num_hash = self.hashmap_number
      words = ""
      num_hash.keys.reverse.each do |magnitude|
        words << "#{convert_to_text(num_hash[magnitude])} #{magnitude} "
      end
      return words.strip
    end
    
    
    # ==================================================================
    # helper methods:
    
    
    def hashmap_number
      # Converts given Fixnum to an array of String => Fixnum hashes
      # keys used in #run to build the final string
      # /\d{3}$/ could maybe be used for up-to-last-three digits matching?
      
      num_string = self.to_s
      num_hash = {}
      
      i = 0
      while num_string.length > 0
        if num_string.length > 2
          num_hash[$ranges[i]] = num_string.slice!(-3, 3).to_i
        else
          num_hash[$ranges[i]] = num_string.slice!(0, num_string.length).to_i
        end
        i += 1
      end
      
      return num_hash.select { |magnitude, digit| digit != 0 }
    end
    
    
    def lookup(hash_name, value)
      # Matches text for all numbers from 0 to 100.
      lookup_hash = { 
      :ones => {    1 => 'one'  ,  2 => 'two', 
                    3 => 'three',  4 => 'four',
                    5 => 'five' ,  6 => 'six',
                    7 => 'seven',  8 => 'eight',
                    9 => 'nine' ,  0 => ''
                  },
      :teens => {   10 => 'ten'     , 11 => 'eleven', 
                    12 => 'twelve'  , 13 => 'thirteen', 
                    14 => 'fourteen', 15 => 'fifteen', 
                    16 => 'sixteen' , 17 => 'seventeen', 
                    18 => 'eighteen', 19 => 'nineteen'
                    },
      :tens => {     1  => 'ten'   ,  2 => 'twenty', 
                     3 => 'thirty' ,  4 => 'forty',
                     5 => 'fifty'  ,  6 => 'sixty',
                     7 => 'seventy',  8 => 'eighty',
                     9 => 'ninety'
                  }
      }
      lookup_hash[hash_name][value]
    end
    
    
    def convert_to_text(number)
      # for digits 0 - 100
      # wishful thinking about metaprogramming
      # digits are stripped from 'number' after they're converted
      number_string = ""
      
      if number > 99
        # Builds the hundreds digit
        number_string << "#{lookup(:ones, number / 100)} hundred "
        number %= 100
      end
      
      if number > 19
        # Builds the tens digit for numbers 20..99
        number_string << "#{lookup(:tens, number / 10) } "
        number %= 10
      end
      
      if number > 9
        # Builds the tens and ones digits for numbers 10..19
        number_string << "#{lookup(:teens, number) } "
        number = 0
      end
      
      # Finishes by building the ones digit
      number_string << "#{lookup(:ones, number) }"
      number_string.chomp(' ')
    end
    
    
    self.run
  end
end