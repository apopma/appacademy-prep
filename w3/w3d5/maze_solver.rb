class MazeSolver
  # http://www.policyalmanac.org/games/aStarTutorial.htm
  attr_reader :maze, :start, :finish, :location,
              :open_list, :closed_list, :parent,
              :movement_cost, :heuristic_cost, :score
              
  MOVE_COST_ORTHO = 10
  MOVE_COST_DIAG  = 14
  
  def initialize
    @maze   = parse(File.readlines(ARGV[0]))
    @start  = find_position('S')
    @finish = find_position('E')
    
    @location = start
    @open_list = [start]
    @closed_list = []
    
    @parent =            {}           #pos => parent's pos
    @movement_cost =     {start => 0} #pos => cost to move there from @start
    @heuristic_cost =    {}           #pos => manhattan cost
    @net_movement_cost = {}           #pos => movement + heuristic costs
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
    p "parents: #{parent}"
  end
  
  def ortho?(source, dest)
    # one coord pair unchanged
    source.each_index do |idx|
      return true if source[idx] - dest[idx] == 0
    end
    false
  end
  
  def diagonal?(source, dest)
    # no coord pairs remain the same
    source.each_index do |idx|
      return false unless source[idx] - dest[idx] != 0
    end
    true
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
      parent[cell] = start
    end
    open_list.delete(location)
    closed_list << location
  end
    
  
  def choose_next_cell
    calculate_movement_costs(open_list)
    estimate_heuristic_costs(open_list)
    calculate_
    
  end
  
  def calculate_movement_costs(cells)
    cells.each do |cell|
      if ortho?(cell, parent[cell])
        movement_cost[cell] = movement_cost[parent[cell]] + MOVE_COST_ORTHO
        
      elsif diagonal?(cell, parent[cell])
        movement_cost[cell] = movement_cost[parent[cell]] + MOVE_COST_DIAG
      end
    end
  end
  
  def estimate_heuristic_costs(cells)
    p cells
    # when each-ing through cell, elements are Fixnum instead of Array. ???
    cells.each do |cell|
      manhattan_cost = 0
      manhattan_cost += (cell[0] - finish[0]).abs
      manhattan_cost += (cell[1] - finish[1]).abs
      p "manhattan cost for #{cell} was #{manhattan_cost}"
      heuristic_cost[cell] = manhattan_cost * MOVE_COST_ORTHO
    end
  end
  
end

test = MazeSolver.new

test.display
test.initial_pathfind
test.listing
puts
test.choose_next_cell