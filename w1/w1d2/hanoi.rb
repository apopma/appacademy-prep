class TowersOfHanoi               # aA pair project: w1d2
                                  # Adam Popma - Jacy Anthis
  #initialize towers
  @rod_a = []
  @rod_b = []
  @rod_c = []
  
  #initialize other variables
  @origin      = []
  @destination = []
  @option      = []
  @number_of_moves = 0
  
  #helper methods
  def self.convert_input(input)
    if input == "a"
      @option = @rod_a
    elsif input == "b"
      @option = @rod_b
    elsif input == "c"
      @option = @rod_c
    else
      puts "Something went wrong! You did not input a rod."
      get_destination_tower
    end
  end
  
  
  def self.get_difficulty_setting
      # could use error handling for nonsensical input ASK TA
      # could also use a regexp?
    num_disks = nil
  
    while num_disks.class != Fixnum || num_disks < 3
      puts "Welcome to Towers of Hanoi! There are always three poles, but how many disks would you like to use? You must use three or more."
      num_disks = gets.chomp.to_i
    end
    return num_disks
  end
  

  def self.get_origin_tower
    #doesn't check validity of input
    puts "Which tower would you like to move a disk from? (a, b, c)"
    origin_tower_s = gets.chomp.downcase
    convert_input(origin_tower_s)
    
    @origin = @option
    if @origin.empty?
      puts "Sorry! That tower is empty."
      get_origin_tower
    end
  end
  
  
  def self.get_destination_tower
    puts "Which tower would you like to move the disk to? (a, b, c)"
    destination_tower_s = gets.chomp.downcase
    convert_input(destination_tower_s)
    
    @destination = @option
    #doesn't check validity of input
    if !( @destination.empty? || (@origin.last < @destination.last) )
      puts "Sorry! You can't put a larger disk on top of a smaller disk."
      get_destination_tower
    end
  end
  
  
  def self.move_disk(origin, destination)
    @destination << @origin.pop
    @number_of_moves += 1
  end

  # main program
  # ===========================================================================
  # TAs: should everything below this be encapsulated in a method?
    
  num_disks = self.get_difficulty_setting
  
  #populate @rod_a with the initial set of disks
  for disk in 1..num_disks
    @rod_a.unshift disk
  end
  
  winning_state = @rod_a  # saves initial state of rod_a to compare for victory
  winning = false         # if either rod duplicates the state of rod A, you win!
  
  
  # play the game
  while !winning
    
    puts "Here is the current state of the towers: #{@rod_a} #{@rod_b} #{@rod_c}"
  # puts "Here is origin and destination: #{@origin} #{@destination}"
    
    self.get_origin_tower
    self.get_destination_tower
    self.move_disk(@origin, @destination)
    
    winning = [@rod_b, @rod_c].any? { |tower| tower == winning_state }  # if either rods B or C match the initial state
    puts "Are you winning? #{winning}"
    if winning
      puts "Congratulations! You're winner!"
      puts "You took #{@number_of_moves} moves to finish this game."
      break
    end
    
  end
  
  
end



towers_of_hanoi
