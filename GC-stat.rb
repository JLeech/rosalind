# GC
contents = File.read('xxx.txt')

splitted_lines = contents.split("\n")
results = {}
current_name = ""

splitted_lines.each do |line|
	if line.start_with?(">")
		current_name = line.strip.sub(">","")
	else
		result = (line.count("G")+line.count("C"))/line.strip.length.to_f
		results[current_name] = result*100
	end
end

max_key = ""
max_val = 0


results.keys.each do |key|
	if results[key] > max_val
		max_key = key
		max_val = results[key]
	end
end

puts max_key
puts max_val