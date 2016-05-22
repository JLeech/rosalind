class Node

	attr_accessor :value
	attr_accessor :connections

	def initialize(value)
		self.value = value
		self.connections = []
	end

end

strings = [
"ATGCG",
"GCATG",
"CATGC",
"AGGCA",
"GGCAT"
]

result = []

strings.each_with_index do |str, index|
	last_strings = strings[index+1..-1]
	break if last_strings.nil?
	last_strings.each do |last_str|
		if last_str[1..-1] == str[0..str.length-2]
			result << "#{last_str} -> #{str}"
		end
		if str[1..-1] == last_str[0..last_str.length-2]
			result << "#{str} -> #{last_str}"
		end
	end
end

puts result.sort

