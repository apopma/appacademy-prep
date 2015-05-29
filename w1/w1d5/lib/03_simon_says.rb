def echo(word)
  word
end

def shout(words)
  words.upcase
end

def repeat(word, times = 2)
  ((word + ' ') * times).strip
end

def start_of_word(word, chars)
  word[0..(chars - 1)]
end

def first_word(words)
  words.split(' ').first
end

def titleize(words) #slightly ugly
  split_words = words.split(' ')
  little_words = ['the', 'and', 'of', 'over', 'for']
  titleized = ''
  
  split_words.each_with_index do |word, idx|
    if little_words.include?(word) && idx != 0
      titleized << word + ' '
    else
      titleized << word[0].upcase + word[1..-1] + ' '
    end
  end
  return titleized.strip
end