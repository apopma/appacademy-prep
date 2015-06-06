def factors(num)
  factors = []
  1.upto(num) do |x|
    factors << x if num % x == 0
  end
  factors
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

def substrings(string)
  # could probably be done without whiles and iterators,
  # but I don't know how to write a cleaner way to loop like this
  substrings = []
  outer_char = 0
  inner_char = 0
  
  while outer_char < string.length
    while inner_char < string.length
      substrings << string[outer_char..inner_char]
      inner_char += 1
    end
    
  outer_char += 1
  inner_char = outer_char
  end
  substrings
end


def subwords(string)
  all_substrings = substrings(string)
  words = []
  
  File.foreach("dictionary.txt") do |line|
    words << line.chomp if all_substrings.include?(line.chomp)
  end
  
  words
end

# =============================================================================

p factors(418)

ary_to_sort = [9, 7, 1, 4, 8, 0, 2, 3, 5, 6]
p ary_to_sort
ary_to_sort.bubble_sort!
p ary_to_sort

p substrings("cat")
p subwords("supercalifragilisticexpialidocious")
p subwords("antidisestablishmentarianism")