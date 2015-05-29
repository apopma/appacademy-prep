class Array
    
  def my_uniq
    new_array = []
    self.each { |x| new_array << x if !new_array.include?(x) }
    return new_array
  end
  
  
  def two_sum
      ans = []
      i = 0
      j = 0
      
      while i < self.count
        while j < self.count
            if self[i] + self[j] == 0 && i != j
            # ugly, but each_with_index is actually uglier
            # i != j prevents matching an index to itself
               ans << [i, j] 
            end
            j += 1
        end
            i += 1
            j = i + 1
      end
      return ans
  end

end


# =============================================================================


my_matrix = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
]


def my_transpose(matrix)
    #new_matrix = Array.new(matrix.size, (Array.new(matrix.size)))
    new_matrix = [
      ['a', 'b', 'c'],
      ['d', 'e', 'f'],
      ['g', 'h', 'i']]
    
    i = 0
    j = 0
    
    while i < matrix.size
        #p matrix[i]
        while j < matrix.size
            #p matrix[i][j]
            #p new_matrix[j][i]
            new_matrix[j][i] = matrix[i][j]
            j += 1
        end
        i += 1
        j = 0
    end
    return new_matrix
end


# =============================================================================


def stock_picks(prices)
  
  best_buy = prices[0]
  best_sell = prices[0]
  best_buy_date = 0
  best_sell_date = 0
  
  prices.each_with_index do |price, day|
    if price < best_buy
      best_buy = price
      best_buy_date = day
    end
    if price > best_sell
      best_sell = price
      best_sell_date = day
    end
  end
  
  puts "Buy on day #{best_buy_date} for #{best_buy}."
  puts "Sell on day #{best_sell_date} for #{best_sell}."
end


# ============================================================================


p [1, 2, 1, 3, 3].my_uniq        # => [1, 2, 3]
p [-1, 0, 2, -2, 1].two_sum      # => [[0, 4], [2, 3]]
p my_transpose(my_matrix)
stock_picks([20, 19, 23, 18, 16, 14, 8, 9, 8, 12, 24, 36])