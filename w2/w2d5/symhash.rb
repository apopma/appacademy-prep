def super_print(string, args = {})
    defaults = { times: 1,
                 upcase: false,
                 reverse: false }
    options = defaults.merge(args)
    
    new_string = string
    new_string.upcase! if options[:upcase]
    new_string.reverse! if options[:reverse]
    
    options[:times].times {print new_string + ' '}
    puts "\n"   # is there a nicer-looking way to insert this \n?
end

super_print("goblin", times: 3, upcase: true, reverse: true)