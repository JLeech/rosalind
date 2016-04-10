
def pattern_to_number(pattern)
	values = pattern.gsub("A","0").gsub("C","1").gsub("G","2").gsub("T","3").reverse
	result = 0
	multiplier = 1
	values.split("").each do |value|
		result += value.to_i * multiplier
		multiplier *= 4
	end
	return result
end

def number_to_pattern(number, k)
	value = number.to_s(4).gsub("0","A").gsub("1","C").gsub("2","G").gsub("3","T")
	while value.length < k
		value = "A"+value
	end
	return value
end

puts number_to_pattern(8066,9)


