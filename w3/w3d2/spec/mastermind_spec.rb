require 'mastermind.rb'

describe Code do
  attr_accessor :code
  
  before do
    @code = Code.new("gorp")
    @game = Game.new
  end
  
  it "initializes properly" do
    code = Code.new("rgby")
    code.cipher.should == [:r, :g, :b, :y]
  end
  
  it "parses uppercase strings properly" do 
    code = Code.new("RGBY")
    code.cipher.should == [:r, :g, :b, :y]
  end
  
  it "generates a random code properly" do
    random_code = Code.random
    random_code.cipher.length.should == 4
    
    random_code.cipher.all? do |char|
      Code::symbols.include?(char).should be true
      #TAs: what does :: mean?
    end
  end
  
  it "matches an identical code" do
    other_code = Code.new("gorp")
    @code.matches(other_code).should == {exact: 4, partial: 0}
  end
  
  it "partially matches a partial match" do
    other_code = Code.new("RGBY")
    @code.matches(other_code).should == {exact: 0, partial: 2}
  end
  
  it "matches exact and partial matches" do
    other_code = Code.new("gopr")
    @code.matches(other_code).should == {exact: 2, partial: 2}
  end
  
  it "matches an annoying test case" do
    code = Code.new("gbbb")
    other_code = Code.new("bggg")
    code.matches(other_code).should == {exact: 0, partial: 2}
  end
  
  it "matches yet another annoying test case" do
    code = Code.new("gbbb")
    other_code = Code.new("gggg")
    code.matches(other_code).should == {exact: 1, partial: 0}
  end
  
  it "matches a third annoying test case" do
    code = Code.new("ggbb")
    other_code = Code.new("yygg")
    code.matches(other_code).should == {exact: 0, partial: 2}
  end
  
  it "does printable work" do
    @code.printable.should == "G, O, R, P"
    Code.new("rgyb").printable.should == "R, G, Y, B"
  end
end


describe Game do
  before do
    @code = Code.new("gorp")
    @game = Game.new
  end
  
  it "generates a secret code" do
    @game.secret_code.cipher.length.should == 4
    @game.secret_code.matches(@game.secret_code).should == {
      exact: 4,
      partial: 0
    }
  end
end

