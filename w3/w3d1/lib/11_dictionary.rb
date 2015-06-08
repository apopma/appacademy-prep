class Dictionary
  attr_accessor :dict
  
  def initialize
    @dict = {}
  end
  
  def entries
    @dict
  end
  
  def keywords
    @dict.keys.sort
  end
  
  def include?(keyword)
    @dict.keys.include?(keyword)
  end
  
  def delete(entry)
    @dict.delete(entry)
  end
  
  
  def add(entry)
    if entry.is_a? String
      @dict[entry] = nil
    elsif entry.is_a? Hash
      entry.each_pair { |key, val| @dict[key] = val }
    else
      raise TypeError, "Dictionary#add expects String or Hash entries"
    end
  end
  
  
  def find(key)
    key_regex = /^((#{key})\w*)/
    found = {}
    @dict.each do |entry, description|
      found[entry] = description if entry =~ key_regex && @dict[entry]
    end
    found
  end
  
  
  def sort
    # Returns a new Hash; @dict sorted alphabetically by keys
    # Replaces nil in entries without a description with ''
    # Does not mutate @dict
    
    sorted_entries = self.keywords
    sorted_descriptions = sorted_entries.map { |entry| @dict[entry] }
    Hash[sorted_entries.zip sorted_descriptions]
  end  
  
  
  def printable
    sorted = self.sort
    output = ""
    sorted.each { |entry, desc| output << "[#{entry}] \"#{desc}\"\n" }
    output.chomp
  end
end