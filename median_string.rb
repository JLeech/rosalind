
def get_combinations(commbination_length)
	flattened = ["A","T","G","C"].permutation(4).to_a
	#combinations =  ["A","T","G","C"].permutation(commbination_length).to_a.flatten.repeated_combination(commbination_length).to_a.uniq.map(&:join)
	return flattened
end

def get_madian_string(samples, medians)

end


puts "#{get_combinations(6)}"