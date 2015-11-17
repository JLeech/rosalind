#SUBS
data = ""

substring = "TATTACCTA"
length = substring.length
positions = []

data.split("").each_with_index do |val,index|
	if val == substring[0]
		if data[index..(index+length-1)] == substring
			positions << index + 1
		end
	end
end

puts positions