def translate(text)
  # thank you j. cheng for the #map code and better-than-mine QU match logic
  vowels = ['a', 'e', 'i', 'o', 'u']
  words = text.split(' ')
  
  translated = words.map do |word|
    if vowels.include?(word[0])
      word + 'ay'
    elsif word.include?('qu')
      qu_index = word.index('u')
      word << word.slice!(0..qu_index) << 'ay'
    else
      word << word.slice!(0..(word.index(/[aeiou]/) - 1)) << 'ay'
    end
  end
  
  translated.join(" ")
end