require 'human_player.rb'


describe HumanPlayer do
  before do
    @test_secret = "aargh"
    @test = HumanPlayer.new
  end
  
  it "guess 'a' and the human gives the right responses" do
    @test.handle_guess_response('a').should == [0, 1]
  end
end