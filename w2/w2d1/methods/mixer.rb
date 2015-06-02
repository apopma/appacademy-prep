def remix(ingredients)
  # doesn't guarantee unique pairing cf. input, but DOES ensure 1:1 matches
  liquors = ingredients.map { |combo| combo[0] }.shuffle
  mixers = ingredients.map { |combo| combo[1] }.shuffle
  
  ingredients.map { |combo| [liquors.shift, mixers.shift] }
end


p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
]) if __FILE__ == $PROGRAM_NAME