class ComputerPlayer
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end
  
  
  def move(board)
    #byebug
    can_win?(board) ? make_winning_move(board) : make_random_move
  end
  
  def make_winning_move(board)
    empties = board.empty_spaces
    empties.each do |empty_space|
      board.place_mark(empty_space, @mark)
      return empty_space if board.won?(@mark)
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
      if board.won?(@mark)
        board.place_mark(empty_space, nil)
        return true
      end
      board.place_mark(empty_space, nil)
    end
    
    return false
  end
end