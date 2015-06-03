class RPNCalculator                           # aA pair project, w2d2
  attr_accessor :calculator, :tokens          # Edward Huang - Adam Popma
  # thank you Wikipedia

  def initialize
    @calculator = []
    @tokens = []
    @operators = ['+', '-', '*', '/', '**', '%']
  end


  def value
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    @calculator[-1]
  end


  def push(x)
    @calculator.push(x)
  end


  def operate(operator)
    #puts "Operating with operator #{operator}, class #{operator.class}"
    case operator
    when :+
      self.plus
    when :-
      self.minus
    when :*
      self.times
    when :/
      self.divide
    when :**
      self.exp
    when :%
      self.mod
    else
      raise NoMethodError, "\nUndefined operator #{operator}"
    end
  end


  def plus
    raise "calculator is empty" if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    @calculator.push(a + b)
  end


  def minus
    raise "calculator is empty" if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    @calculator.push(a - b)
  end


  def times
    raise "calculator is empty" if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    @calculator.push(a * b)
  end


  def divide
    raise "calculator is empty" if @calculator.empty?
    b = @calculator.pop.to_f
    a = @calculator.pop.to_f
    @calculator.push(a / b)
  end


  def exp
    raise "calculator is empty" if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    @calculator.push(a ** b)
  end


  def mod
    raise "calculator is empty" if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    @calculator.push(a % b)
  end


  def tokens(string)
    string.split(' ').each do |token|
      if @operators.include?(token)
        @tokens << token.to_sym
      else
        @tokens << token.to_i
      end
    end
    return @tokens
  end


  def evaluate(string)
    self.tokens(string)
    #puts "Tokens: #{@tokens.to_s}"

    @tokens.each do |token|
      #puts "\nCurrent token #{token}, class #{token.class}"
      if token.class == Symbol
        self.operate(token)
      else
        @calculator.push(token)
      end
      #puts "Calculator stack: #{@calculator.to_s}"
    end

    return self.value
  end
end


# =============================================================================


if __FILE__ == $PROGRAM_NAME
  calculator = RPNCalculator.new
  
  if !ARGV.empty? # run the arguments specified in ARGV
  
    File.foreach(ARGV[0]) do |line|
      puts calculator.evaluate(line)
    end
    
  else #accept user input and evaluate it
    print "No args given, please enter some args: "
    args_array = []
    args = gets
    
    while args != "\n"
      # this shovel needs to occur before the second gets assignment
      args_array << args
      args = gets
    end 
    
    if args_array.empty?
      puts "no arguments entered, please try again"
    else
      puts calculator.evaluate(args_array.join(""))
    end
  end
end