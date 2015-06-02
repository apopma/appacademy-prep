def remix(ingredients)
  # thanks to j. latimer for the new_cocktails.none? logic
  liquors = ingredients.map { |combo| combo[0] }
  mixers = ingredients.map { |combo| combo[1] }
  new_cocktails = ingredients             # initializing it as [] breaks #none?
  
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