class MazeSolver
  attr_reader :maze, :start, :finish
  
  def initialize
    @maze   = parse(File.readlines(ARGV[0]))
    @start  = find_position('S')
    @finish = find_position('E')
  end
  
  def [](row, col)
    maze[row][col]
  end
  
  def []=(row, col, mark)
    maze[row][col] = mark
  end
  
  def display
    maze.each {|line| puts line.join}
    puts "start location is #{start}"
    puts "ending location is #{finish}"
  end
  
  def parse(raw_maze)
    # Transforms a raw File#readlines array into a 2D array.
    # Also initializes @maze with the proper array bounds.
    maze = Array.new(raw_maze.size) { Array.new(raw_maze.first.size) }
    
    maze = raw_maze.map.with_index do |line, row|
      line.chomp.split('').each_with_index do |char, col|
        maze[row][col] = char
      end
    end
  end
  
  def find_position(char)
    # Searches @maze for the first row including the character of interest.
    # Then returns the first-located pos of that character in the maze.
    row = maze.detect { |this_row| this_row.include?(char) }
    [maze.index(row), row.index(char)]
  end
  
end

MazeSolver.new.display