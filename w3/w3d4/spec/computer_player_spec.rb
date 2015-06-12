require 'computer_player.rb'

describe ComputerPlayer do
  before do
    @test = ComputerPlayer.new
  end
  
  it "handles a human's guess properly" do
    @test.secret_word = "aargh"
    @test.handle_guess_response('a').should == [0, 1]
  end
end