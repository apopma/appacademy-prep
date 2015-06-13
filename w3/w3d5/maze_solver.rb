class MazeSolver
  attr_reader :maze, :start, :finish, :location,
              :open_list, :closed_list, :parents
  MOVE_ORTHO = 10
  MOVE_DIAG  = 14
  
  def initialize
    @maze   = parse(File.readlines(ARGV[0]))
    @start  = find_position('S')
    @finish = find_position('E')
    
    @location = start
    @open_list = [start]
    @closed_list = []
    
    @parents = {} #pos => parent's pos
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
    puts "current location is #{location}"
  end
  
  def listing
    p "open cells: #{open_list}"
    p "closed cells: #{closed_list}"
    p "parents: #{parents}"
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
  
  
  def reachable_cells
    # Returns an array of all reachable cells from @location,
    # ignoring walls, and cells on the closed list.
    
    curr_row = location[0]
    curr_col = location[1]
    
    all_possible_moves = [ 
          [curr_row, curr_col + 1],     [curr_row, curr_col - 1],
          [curr_row + 1, curr_col],     [curr_row - 1, curr_col],
          [curr_row + 1, curr_col + 1], [curr_row + 1, curr_col - 1],
          [curr_row - 1, curr_col + 1], [curr_row - 1, curr_col - 1]
                         ]
                         
    all_possible_moves.reject do |this_move|
      self[*this_move] == '*' || closed_list.include?(this_move)
    end
  end
    
    
  def initial_pathfind
    # Adds all reachable cells from @start to the open list,
    # and moves @start to the closed list.
    # Cells have their pos and the adding cell (@start) saved to @parents.
    reachable_cells.each do |cell| 
      open_list << cell
      parents[cell] = start
    end
    open_list.delete(location)
    closed_list << location
  end
  
end

test = MazeSolver.new

test.display
test.initial_pathfind
test.listing