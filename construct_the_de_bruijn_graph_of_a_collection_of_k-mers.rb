#generate = -> str, k { (0..str.size-k).map{ |x| str[x,k] } }

#string = "AAGATTCTCTAC"

#strings = generate [string, 3].uniq.sort

strings = ['GAGG','CAGG','GGGG','GGGA','CAGG','AGGG','GGAG']

result = Hash.new { |hash, key| hash[key] = [] }

strings.each_with_index do |str, index|
	to = str[1..-1]
	from = str[0..str.length-2]
	result[from] << to
end

result.keys.sort.each do |key|
	puts "#{key} -> #{result[key].sort.join(",")}"
end
