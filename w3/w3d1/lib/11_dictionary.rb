class Dictionary
  attr_accessor :dict
  
  def initialize
    @dict = {}
  end
  
  def entries
    @dict
  end
  
  def keywords
    # returns @dict keys sorted alphabetically
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
    @dict.select { |entry, desc| entry.match(key) && @dict[entry] }
  end
  
  
  def sort
    sorted_descriptions = keywords.map { |entry| @dict[entry] }
    Hash[keywords.zip sorted_descriptions]
  end  
  
  
  def printable
    output = ""
    sort.each { |entry, desc| output << "[#{entry}] \"#{desc}\"\n" }
    output.chomp
  end
end