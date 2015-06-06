class Fixnum
  def factors
    factors = []
    1.upto(self) do |x|
      factors << x if self % x == 0
    end
    factors
  end
end

# -----------------------------------------------------------------------------

class Array
  def bubble_sort!
    ary_not_sorted = true
    
    while ary_not_sorted
      ary_not_sorted = false
      
      1.upto((self.length - 1)) do |num|
        # puts "Matching #{num - 1} and #{num} - (#{self[num - 1]} / #{self[num]})"
        if self[num - 1] > self[num]
          self[num - 1], self[num] = self[num], self[num - 1]
          ary_not_sorted = true
        end
      end
    end
    
  end
end

# -----------------------------------------------------------------------------

class String
  
  def substrings
    # could probably be done without whiles and iterators,
    # but I don't know how to write a cleaner way to loop like this
    substrings = []
    outer_char = 0
    inner_char = 0
    
    while outer_char < self.length
      while inner_char < self.length
        substrings << self[outer_char..inner_char]
        inner_char += 1
      end
      
      outer_char += 1
      inner_char = outer_char
    end
    substrings
  end


  def subwords
    all_substrings = self.substrings
    words = []
    
    File.foreach("dictionary.txt") do |line|
      words << line.chomp if all_substrings.include?(line.chomp)
    end
    
    words
  end
  
end

# =============================================================================

p 418.factors

ary_to_sort = [9, 7, 1, 4, 8, 0, 2, 3, 5, 6]
p ary_to_sort
ary_to_sort.bubble_sort!
p ary_to_sort

p "cat".substrings
p "supercalifragilisticexpialidocious".subwords
p "antidisestablishmentarianism".subwords