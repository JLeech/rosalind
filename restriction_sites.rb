data = ""
head_position = 1
tail_position = 0

reverse_comp = {"A"=>"T","G"=>"C","T"=>"A","C"=>"G"}
current_poly_position = 0
current_poly_length = 0
polys = []


data.length.times do

	if data[head_position] == reverse_comp(data[tail_position])
		if current_poly_length == 0
			
		end
	end


end

