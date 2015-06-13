require 'byebug'

class MazeSolver
  # http://www.policyalmanac.org/games/aStarTutorial.htm
  attr_reader :maze, :start, :finish,
              :open_list, :closed_list, :parent,
              :movement_cost, :heuristic_cost, :net_movement_cost
  attr_accessor :location
              
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
    puts "current location is #{@location}"
  end
  
  def listing
    p "open cells: #{open_list}"
    p "closed cells: #{closed_list}"
    p "parents: #{parent}"
  end
  
  
  def solve
    display
    initial_pathfind
    choose_next_cell
    display
    
    until closed_list.include?(finish)
      pathfind
      display
    end
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
    reachable_cells.each do |reachable_cell| 
      open_list << reachable_cell
      parent[reachable_cell] = start
    end
    open_list.delete(location)
    closed_list << location
  end
  
  
  def pathfind
    puts "i'm pathfinding!"
    
    open_list.delete(location)
    closed_list << location unless closed_list.include?(location)
    
    reachable_cells.each do |reachable_cell|
      if open_list.include?(reachable_cell)
        puts "#{reachable_cell} was already reachable"
        update_movement_cost(reachable_cell)
        
      elsif !(open_list.include?(reachable_cell))
        puts "#{reachable_cell} is newly reachable"
        open_list << reachable_cell 
        parent[reachable_cell] = location
      end
      
    end
    
    choose_next_cell
  end
  
  
  def update_movement_cost(cell)
    if ortho?(cell, parent[cell])
      movement_cost[cell] = movement_cost[parent[cell]] + MOVE_COST_ORTHO
      
    elsif diagonal?(cell, parent[cell])
      movement_cost[cell] = movement_cost[parent[cell]] + MOVE_COST_DIAG
    end
    
    current_movement_cost = movement_cost[cell]
    parent_movement_cost = movement_cost[parent[cell]]
    puts "Updating movement costs for #{cell} with current parent #{parent[cell]}"
    new_movement_cost = 0
    
    if ortho?(parent[cell], cell)
      new_movement_cost = parent_movement_cost + MOVE_COST_ORTHO
      
    elsif diagonal?(parent[cell], cell)
      new_movement_cost = parent_movement_cost + MOVE_COST_DIAG
    end
    
    puts "current cost #{movement_cost[cell]}, 
          parent cost #{movement_cost[parent[cell]]},
          possible new cost #{new_movement_cost}"
    
    if new_movement_cost < current_movement_cost
      puts "Found faster move #{new_movement_cost} for cell #{cell}"
      puts "Previous parent of #{cell} was #{parent[cell]}"
      movement_cost[cell] = new_movement_cost
      parent[cell] = location
      puts "Updated #{cell} parent to #{location}"
      puts "Calculating new Manhattan and F scores..."
      estimate_heuristic_costs(cell)
      calculate_net_costs(cell)
    end
  end
    
  
  def choose_next_cell
    # why does this need to be @location here and in #display, but nowhere else?
    calculate_movement_costs(open_list)
    estimate_heuristic_costs(open_list)
    calculate_net_costs(open_list)
    
    puts "movement costs: #{net_movement_cost.sort}"
    p "open list: #{open_list}"
    p "closed list: #{closed_list}"
    
    candidate_locations = net_movement_cost.reject do |pos, val|
      net_movement_cost.keys.include?(pos) && pos == @location
    end
    
    p candidate_locations
    
    candidate_locations.each do |pos, val|
      if val == candidate_locations.values.min
        puts "the next location is #{candidate_locations.key(val)}"
        @location = candidate_locations.key(val)
        self[*location] = "•"
        return
      end
    end
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
    # when each-ing through cell, elements are Fixnum instead of Array. ???
    cells.each do |cell|
      manhattan_cost = 0
      manhattan_cost += (cell[0] - finish[0]).abs
      manhattan_cost += (cell[1] - finish[1]).abs
      #p "manhattan cost for #{cell} was #{manhattan_cost}"
      heuristic_cost[cell] = manhattan_cost * MOVE_COST_ORTHO
    end
  end
  
  def calculate_net_costs(cells)
    cells.each do |cell|
      net_movement_cost[cell] = (movement_cost[cell] + heuristic_cost[cell])
      #p "F score for #{cell} was #{net_movement_cost[cell]}"
    end
  end
  
end

test = MazeSolver.new

test.solve