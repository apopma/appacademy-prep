class Shuffler
  attr_accessor :readfile
  
  def initialize
    print "Enter a file name to read (no extension): "
    @readfile = gets.chomp
  end
  
  
  def run
    shuffled_file = File.readlines("#{@readfile}.txt")
    shuffled_file.map! { |line| line.delete("\n") }.shuffle!
    
    File.open("#{@readfile}-shuffled.txt", "w") do |f|
      shuffled_file.each { |line| f.puts line }
    end
    
    puts "Mangled up #{@readfile}.txt into #{@readfile}-shuffled.txt"
    # TAs: is it okay to have one extra newline (and nothing else) at EOF?
  end
end


Shuffler.new.run if __FILE__ == $PROGRAM_NAME