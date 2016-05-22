class Node

	attr_accessor :value
	attr_accessor :connections

	def initialize(value)
		self.value = value
		self.connections = []
	end

end
generate = -> str, k { (0..str.size-k).map{ |x| str[x,k] } }

string = "AAGATTCTCTAC"

strings = generate [string, 3].uniq.sort

result = Hash.new { |hash, key| hash[key] = [] }

strings.each_with_index do |str, index|
	last_strings = strings[index+1..-1]
	break if last_strings.nil?
	last_strings.each do |last_str|
		if last_str[1..-1] == str[0..str.length-2]
			result[last_str] << str
		end
		if str[1..-1] == last_str[0..last_str.length-2]
			result[str] << last_str
		end
	end
end

result.keys.sort.each do |key|
	puts "#{key} -> #{result[key].join(",")}"
end
