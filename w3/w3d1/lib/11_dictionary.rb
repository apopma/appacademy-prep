require 'byebug'


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
  
  def find(key)
    key_regex = /^((#{key})\w*)/
    found = {}
    @dict.each do |entry, description|
      if entry =~ key_regex && !@dict[entry].nil?
        found[entry] = description 
      end 
    end
    found
  end
  
  def include?(keyword)
    @dict.keys.include?(keyword)
  end
  
  
  def sort
    # Returns a new Hash; @dict sorted alphabetically by keys
    # Replaces nil in entries without a description with ''
    # Does not mutate @dict
    sorted_entries = self.keywords
    unsorted_descriptions = @dict.values
    
    unsorted_descriptions.map! { |desc| desc ||= '' }
    sorted_descriptions = sorted_entries.map { |entry| @dict[entry] }
    
    Hash[sorted_entries.zip sorted_descriptions]
  end  
  
  def add(entry)
    if entry.is_a? String
      @dict[entry] = nil
    elsif entry.is_a? Hash
      entry.each_pair { |key, val| @dict[key] = val }
    else
      raise TypeError, "A booming voice says, 'Wrong, cretin!', 
            and you notice that you have turned into a pile of dust.
            How inconvenient."
    end
  end
  
  def delete(entry)
    @dict.delete(entry)
  end
  
  def printable
    sorted = self.sort
    output = ""
    sorted.each { |entry, desc| output << "[#{entry}] \"#{desc}\"\n" }
    output.chomp
  end
  
end