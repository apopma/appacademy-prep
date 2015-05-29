def num_to_s(num, base)
  pow = 0
  num_string = ''
  
  conversion_hash = {
    0 => '0',
    1 => '1',
    2 => '2',
    3 => '3',
    4 => '4',
    5 => '5',
    6 => '6',
    7 => '7',
    8 => '8',
    9 => '9',
    10 => 'A',
    11 => 'B',
    12 => 'C',
    13 => 'D',
    14 => 'E',
    15 => 'F'
  }
  
  while (num / (base ** pow) != 0)
    #puts "#{base} ^ #{pow} = #{base ** pow}"
    #puts "Inserting #{num / (base ** pow)}\n\n"
    converted_num = conversion_hash[ (num / (base ** pow) ) % base]
    num_string << converted_num
    pow += 1
  end
  
  #puts num_string.reverse 
  #how could I add values to num_string so that this reverse is unnecessary?
end


num_to_s(5, 10)   #=> "5"
num_to_s(5, 2)    #=> "101"
num_to_s(5, 16)   #=> "5"

num_to_s(234, 10) #=> "234"
num_to_s(234, 2)  #=> "11101010"
num_to_s(234, 16) #=> "EA"


# ==============================================================================


def caesar(word, shift)
  # for a single word only
  ascii_text = []
  shifted_word = ''
  
  word.split('').each { |char| ascii_text << char.ord }
  
  ascii_text.each_with_index do |char, index|
    ascii_text[index] = (char + shift)
    ascii_text[index] -= 26 if ascii_text[index] >= 123
  end
  
  ascii_text.each { |ascii| shifted_word << ascii.chr }
  return shifted_word
end


puts caesar("hello", 3)  # => "khoor"
puts caesar("xyz", 3)    # => "abc"
puts caesar('abcxyz', 3) # => "defabc"