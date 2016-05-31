def data_to_array(data)
	return data.gsub("(","").gsub(")","").split(" ").map(&:to_i)
end

def make_reverse(start, finish, data)
	finish = finish[0] if finish.class == Array
	sub_data = data[start..finish]
	sub_data = sub_data.reverse.map{ |x| x*-1 }
	sub_data.each_with_index { |elem, index| data[start+index] = elem }
	return data
end

def sorted?(data)
	data.each_with_index do |elem, index|
		next if index == 0
		
		return false if elem - data[index-1] != 1
	end
	return true
end

def add_minus(x)
	return "+#{x}" if !x.start_with?("-")
	return x
end

def greedy_sort(data)
	current_position = 1
	while true 

		return data if sorted?(data)
		position = [data.index(current_position), data.index(-current_position)].compact
		data = make_reverse(current_position-1, position, data)
		puts "(#{data.map(&:to_s).map{|x| add_minus(x)}.join(' ')})"
		if data[current_position-1] < 0 
			data = make_reverse(current_position-1, current_position-1, data) 
			puts "(#{data.map(&:to_s).map{|x| add_minus(x)}.join(' ')})"
		end
		current_position += 1
	end
end

data = data_to_array("(-6 +1 +2 +3 +4 +5)")
greedy_sort(data)