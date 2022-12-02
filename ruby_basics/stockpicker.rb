def stock_picker(prices)
#   buy = 0
#   sell = 1
#   bestbuy = 0
#   bestsell = 0
#   profit = 0
  
# while buy < prices.length-1 
#   if sell <= prices.length-1 
#     if prices[sell] - prices[buy] < profit
#       sell += 1
#     elsif prices[sell] - prices[buy] > profit
#       bestbuy = buy
#       bestsell = sell
#       profit = prices[sell] - prices[buy]
#       sell += 1
#     end
#   elsif sell = prices.length - 1
#     buy += 1
#     sell = buy + 1
#   end
# end
# puts [bestbuy,bestsell,profit]


bestbuy = 0
bestsell = 0
profit = 0

prices.each_with_index do |buy, index|
  prices.each_with_index do |sell, idx|
    result = sell - buy
    if result > profit && idx > index
      bestsell = sell
      bestbuy = buy
      profit = result
    end
  end
end
puts [bestbuy, bestsell, profit]
end

stock_picker([17,3,6,9,15,8,6,1,10])
