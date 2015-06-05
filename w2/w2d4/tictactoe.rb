require 'byebug'

class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end
  
  def [](row, col)
    @grid[row][col]
  end
  
  def []=(row, col, mark)
    @grid[row][col] = mark #sets mark
  end
  
  def display
    @grid.each do |row| 
      p row
    end
  end
  
  
  def winning?(ary, mark)
    # tests any set of three coords for rows, cols, and diagonals
    ary.all? {|position| position == mark}
  end
  
  def row_win?(mark)
    @grid.each do |row|
      return true if winning?(row, mark)
    end
    false
  end
  
  def col_win?(mark)
    transposed_grid = @grid.transpose
    transposed_grid.each do |col|
      return true if winning?(col, mark)
    end
    false
  end
  
  def diag_win?(mark)
    diag_1 = [self[0, 0], self[1, 1], self[2, 2]]
    diag_2 = [self[2, 0], self[1, 1], self[0, 2]]
    return true if winning?(diag_1, mark) || winning?(diag_2, mark)
    false
  end
    
  def won?(mark)
    return true if row_win?(mark) || (col_win?(mark) || diag_win?(mark))
    false
  end
  
  def empty?(row, col)
    self[row, col].nil?
  end
  
  def empty_spaces
    empties = []
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        empties << [row_idx, col_idx] if self[row][col].nil?
      end
    end
    empties
  end

  def place_mark(pos, mark) # 3 args
    self[*pos] = mark
  end
  
  def legal_move?(pos)
    # True if indices given are between 0 and 2, and no move exists at this pos
    return false if !pos.all? { |coord| coord.between?(0, 2) }
    return false if !self[*pos].nil?
    true
  end
  
  def is_full?
    @grid.flatten.compact.length == 9
  end
  
  def tie?
    is_full? && (!won?(:x) && !won?(:o))
  end
  
end

# ------------------------------------------------------------------------------

class Game
  attr_accessor :players, :board
  
  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new
  end
  
  def play
    while true
      @players.each_with_index do |player, idx|
        puts "It's player #{idx + 1}'s turn. (#{player.mark})"
        @board.display
        
        mark = player.mark
        coords = player.move(@board)
        @board.place_mark(coords, mark)
          
        if @board.won?(mark)
          puts "#{mark.upcase} wins the game!"
          return
        elsif @board.tie?
          puts "This game's a tie!"
          return
        end
        
      end
    end
  end
end

# -----------------------------------------------------------------------------


class HumanPlayer
  attr_reader :mark
  def initialize(mark)
    @mark = mark
  end
  
  def move(board)
    while true 
      print "Please enter a grid coordinate to mark (ex: '1, 2'): "
      coords = gets.chomp.split(",").map(&:to_i)
      
      if !board.legal_move?(coords)
        puts "Sorry, that move's illegal!"
      else
        break
      end
    end
    coords
  end
end

# -----------------------------------------------------------------------------

class ComputerPlayer
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end
  
  
  def move(board)
    can_win?(board) ? make_winning_move : make_random_move
  end
  
  def make_winning_move
    empties = board.empty_spaces
    empties.each do |empty_space|
      board.place_mark(empty_space, @mark)
      return empty_space if board.won?
    end
    puts "Something went wrong! make_winning_move should always win!"
  end
  
  def make_random_move
    row = [0, 1, 2].sample
    column = [0, 1, 2].sample
    [row, column]
  end
  
  def can_win?(board)
    empties = board.empty_spaces
    empties.each do |empty_space|
      board.place_mark(empty_space, @mark)
      if board.won?
        return true
      else
        board.place_mark(empty_space, nil)
      end
      false
    end
  end
end
  
# =============================================================================

game_type = 0
marks = [:x, :o]
p1_mark = nil
p2_mark = nil


puts "Welcome to tic-tac-toe!"
print "Single player or two-player? (enter 1 or 2) "
until game_type.between?(1, 2)
  game_type = gets.chomp.to_i
  
  if game_type == 1
    puts "You're playing against a computer!"
    puts "Do you want to play Xs or Os? (enter X or O)"
    
    p1_mark = gets.chomp.downcase.to_sym
    until marks.include?(p1_mark)
      puts "Sorry, you can't play Tic-Tac-Toe with that kind of mark."
      print "Please enter Xs or Os: "
      p1_mark = gets.chomp.downcase.to_sym
    end
    p2_mark = marks.delete_if {|mark| mark == p1_mark}.first
    
    puts "You picked #{p1_mark.upcase}."
    puts "The computer picked #{p2_mark.upcase}."
    
    puts "Let's play the game!"
    game = Game.new(HumanPlayer.new(p1_mark), 
                    ComputerPlayer.new(p2_mark))
    game.play
    
    
  elsif game_type == 2
    puts "You're playing against somebody else!"
    puts "Player 1, do you want to play Xs or Os? (enter X or O)"
    
    p1_mark = gets.chomp.downcase.to_sym
    until marks.include?(p1_mark)
      puts "Sorry, you can't play Tic-Tac-Toe with that kind of mark."
      print "Please enter Xs or Os: "
      p1_mark = gets.chomp.downcase.to_sym
    end
    p2_mark = marks.delete_if {|mark| mark == p1_mark}.first
    
    puts "Player 1 picked #{p1_mark.upcase}."
    puts "Player 2 picked #{p2_mark.upcase}."
    puts "Let's play the game!"
    game = Game.new(HumanPlayer.new(p1_mark), 
                    HumanPlayer.new(p2_mark))
    game.play
    
    
  else
    puts "Sorry, you can't play Tic-Tac-Toe with that many players."
    print "Please enter 1 or 2 players: "
  end
  
  
end