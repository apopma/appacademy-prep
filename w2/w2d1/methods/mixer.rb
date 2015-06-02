def remix(ingredients)
  # thanks to j. latimer for the new_cocktails.none? logic
  # for the adventurous: liquors, mixers = ingredients.transpose
  
  liquors = ingredients.map(&:first)
  mixers = ingredients.map(&:last)
  new_cocktails = make_new_cocktails(liquors, mixers)
  
  until new_cocktails.none? { |mix| ingredients.include?(mix) }
    new_cocktails = make_new_cocktails(liquors, mixers)
  end
  new_cocktails
end


def make_new_cocktails(liquors, mixers)
  liquors.shuffle!
  mixers.shuffle!
  
  liquors.map.with_index do |liquor, idx|
    [liquor, mixers[idx]]
  end
end


if __FILE__ == $PROGRAM_NAME
  p new_drinks = remix([
    ["rum", "coke"],
    ["gin", "tonic"],
    ["scotch", "soda"]
  ])
end