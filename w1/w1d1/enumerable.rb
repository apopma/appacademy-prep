def multiply_all_elements(nums)
  nums.inject(1) {|product, num| product * num}
  # it can also be nums.inject(:*) but this is more illustrative
end

puts multiply_all_elements([1, 2, 3, 4, 5])     # => 120


# =============================================================================


def is_perfect_square?
  square_roots = (1..100).map { |integer| Math.sqrt(integer) }
  square_roots.select { |num| num.to_s.split('.').last.size == 1 }
  # mostly from stackoverflow; gets square roots and only returns integers
end

puts is_perfect_square?.to_s                    # => (1..10)


# =============================================================================


puts (1..5).any? { |i| i % 2 != 0 }             # => true for 1, 3, 5


# =============================================================================


def multiply_by_two(nums)
  nums.map { |i| i * 2 }
end

p multiply_by_two([1, 2, 3, 4, 5])              # => [2, 4, 6, 8, 10]


# =============================================================================

# ???????????????? I don't even

class Array
  def my_each(&prc)
    # using `Array#each` is cheating!`
    self.count.times { |i| prc.call(self[i]) }

    # return original array
    self
  end
end


# calls my_each twice on the array, printing all the numbers twice.
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end
# =>  1
#     2
#     3
#     1
#     2
#     3

p return_value # => [1, 2, 3]
# =============================================================================


def median(integers)
  # mostly from github.com/apopma/stats
  sorted_ints = integers.sort
  
  if sorted_ints.length % 2 == 0
    middle1 = sorted_ints[sorted_ints.length / 2]
    middle2 = sorted_ints[(sorted_ints.length / 2) - 1]
    return (middle1 + middle2) / 2.0
    
  else
    return sorted_ints[sorted_ints.length / 2]
  end
end

puts median([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])    # => 5.5
puts median([1, 2, 3, 4, 5, 6, 7, 8, 9])        # => 5


# =============================================================================


def concatenate(strings)
  strings.inject("") { |accum, string| accum += string }
end

puts concatenate(["Yay ", "for ", "strings!"])  # => "Yay for strings!"


# =============================================================================