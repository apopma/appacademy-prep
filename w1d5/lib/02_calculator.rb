def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

def sum(nums)
  nums.inject(0, :+)
end

def multiply(a, b)
  #nums.inject(0, :*) # would work as with sum; specs are for 2 only
  a * b
end

def power(num, exponent)
  num ** exponent
end

def factorial(num)
  #shamelessly cribbed from stackoverflow
  (1..num).inject(1, :*)
end