
def with_memoization(money, coins, remembered_data = [])
	return 0, remembered_data if money == 0
	return remembered_data[money], remembered_data if remembered_data[money] != nil
	results = []
	min_num_coins = 99999999999
	coins.each do |coin|
		if money >= coin
			num_coins, remembered_data = with_memoization(money - coin, coins, remembered_data)
			min_num_coins = num_coins + 1 if num_coins + 1 < min_num_coins
		end
	end
	remembered_data[money] = min_num_coins
	return min_num_coins, remembered_data
end

def pre_fill_memoization(money, coins)
	remembered_data = []
	coins.each { |coin| remembered_data[coin] = 1 }
	remembered_data[0] = 0
	(money+10).times do |time|
		_, remembered_data = with_memoization(time, coins, remembered_data)
	end
	return remembered_data[money]
end

puts pre_fill_memoization(16569,[1,3,5,20])