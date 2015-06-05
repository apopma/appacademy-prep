require_relative "game"                 # aA pair project: w2d4
require_relative "board"                # Adam Popma - Jake Singh
require_relative "computer_player"      # thanks to John Cipriano
require_relative "human_player"         # for extensive helping
                 
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