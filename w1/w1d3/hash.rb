class MyHashSet
  attr_reader :store
  
  def initialize
    @store = {}
  end
  
  
  def insert(el)
    store[el] = true
  end
  
  
  def include?(el)
    store.has_key?(el)
  end
  
  
  def delete(el)
    item_in_set = store.include?(el)
    store.delete(el)
    return item_in_set
  end
  
  
  def union(set2)
    store.merge(set2.store)
  end
  
  
  def intersect(set2)
    intersection = {}
    store.each do |key, val|
      intersection[key] = val if store.include?(key) && set2.store.include?(key)
    end
    return intersection
  end
  
  
  def minus(set2)
    minus_set = {}
    store.each do |key, val|
      minus_set[key] = val if store.include?(key) && !set2.store.include?(key)
    end
    return minus_set
  end
  
  
end


# ==============================================================================


my_hash = MyHashSet.new
my_hash.insert("truthiness")
puts "my_hash contains truthiness? #{ my_hash.include?("truthiness") } \n\n"


my_other_hash = MyHashSet.new
my_other_hash.insert("rectitude")
union_hash = my_hash.union(my_other_hash)
puts "union_hash has truthiness: #{ union_hash.include?("truthiness") }"
puts "union_hash has rectitude: #{ union_hash.include?("rectitude") } \n\n"


my_hash.insert("rectitude")
my_hash.insert("embiggening")
my_other_hash.insert("cromulence")
intersect_hash = my_hash.intersect(my_other_hash)
puts "intersection has rectitude: #{ intersect_hash.include?("rectitude") }"
puts "intersection has cromulence: #{ intersect_hash.include?("cromulence") }\n\n"


minus_hash = my_hash.minus(my_other_hash)
puts "minus should contain truthiness and embiggening, but not rectitude or cromulence"
puts "minus has truthiness: #{ minus_hash.include?("truthiness") }"
puts "minus has embiggening: #{ minus_hash.include?("embiggening") }"
puts "minus has rectitude: #{ minus_hash.include?("rectitude") }"
puts "minus has cromulence: #{ minus_hash.include?("cromulence") }"