class RPNCalculator                           # aA pair project, w2d2
  attr_accessor :calculator, :tokens          # Edward Huang - Adam Popma

  def initialize
    @calculator = []
    @tokens = []
    @Operators = ['+', '-', '*', '/', '**', '%']
  end


  def value
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    @calculator[-1]
  end


  def push(x)
    @calculator.push(x)
  end


  def operate(operator)
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    push(a.send(operator, b))
  end


# ----------------------------------------------------------------------------
# below methods are only here to make the tests pass
# RPNCalculator#operate can handle all of these plus string evaluations

  def plus
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    push(a + b)
  end


  def minus
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    push(a - b)
  end


  def times
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    push(a * b)
  end


  def divide
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    b = @calculator.pop.to_f
    a = @calculator.pop.to_f
    push(a / b)
  end


  def exp
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    push(a ** b)
  end


  def mod
    raise ArgumentError, 'calculator is empty' if @calculator.empty?
    b = @calculator.pop
    a = @calculator.pop
    push(a % b)
  end
  
# -----------------------------------------------------------------------------

  def tokens(string)
    # should be 'tokenize' but that breaks the specs
    string.split(' ').each do |token|
      if @Operators.include?(token)
        @tokens << token.to_sym
      else
        @tokens << token.to_f
      end
    end
    return @tokens
  end


  def evaluate(string)
    tokens(string)

    @tokens.each do |token|
      if token.class == Symbol
        operate(token)
      else
        push(token)
      end
    end

    value
  end
end


# =============================================================================


if __FILE__ == $PROGRAM_NAME
  calculator = RPNCalculator.new
  
  if !ARGV.empty? 
    # run the arguments specified in ARGV
    File.foreach(ARGV[0]) do |line|
      ans = calculator.evaluate(line)
      ans == ans.to_i ? (puts ans.to_i) : (puts ans)
    end
    
  else #accept user input and evaluate it
    puts "   RPN Calculator 9000 \n========================="
    puts "Enter numbers (8, 42, 1189.4)"
    puts "or operators (+, -, *, /, **, ^)."
    puts "Postfix notation: 3 - 2 would be entered as 3 2 -"
    print "Press Enter twice when done: "
    args_array = []
    args = gets
    
    while args != "\n"
      # this shovel needs to occur before the second gets assignment
      args_array << args
      args = gets
    end 
    
    if args_array.empty?
      puts "No arguments entered, please try again"
    else
      ans = calculator.evaluate(args_array.join(""))
      ans == ans.to_i ? (puts ans.to_i) : (puts ans)
    end
    
  end
end