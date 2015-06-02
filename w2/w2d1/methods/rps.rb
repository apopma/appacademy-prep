def rps(player_choice)
  computer_choice = random_choice
  return "#{computer_choice}, Draw" if player_choice == computer_choice
  
  if winner?(player_choice, computer_choice) 
    "#{computer_choice}, Win"
  else
    "#{computer_choice}, Lose"
  end
end


def random_choice
  choices = { 1 => "Rock", 2 => "Paper", 3 => "Scissors" }
  choices[rand(1..3)]
end


def winner?(player, opponent)
  case player
    when "Rock"
      opponent == "Scissors" ? true : false
    when "Paper"
      opponent == "Rock" ? true : false
    when "Scissors"
      opponent == "Paper" ? true : false
  end
end


puts rps(random_choice) if __FILE__ == $PROGRAM_NAME


