def super_print(string, args = {})
    defaults = { times: 1,
                 upcase: false,
                 reverse: false }
    options = defaults.merge(args)
    
    string.upcase! if options[:upcase]
    string.reverse! if options[:reverse]
    
    options[:times].times {print string + ' '}
    puts "\n"   # is there a nicer-looking way to insert this \n?
end

super_print("goblin", times: 3, upcase: true, reverse: true)