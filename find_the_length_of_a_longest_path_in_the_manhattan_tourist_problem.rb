class Node
	
	attr_accessor :right
	attr_accessor :down
	attr_accessor :value
	attr_accessor :diag
	attr_accessor :path

	def initialize(diag = 0)
		self.down = 0
		self.right = 0
		self.diag = diag
		self.value = 0
		self.path = 0
	end
 # 0 -diag / 1 - up, 2 - left
end

def form_path_matrix_by_strings(up, left)
	path_matrix = []
	left.split("").each do |left_char|
		matrix_line = []	
		up.split("").each do |up_char|
			diag = left_char == up_char ? 1 : 0
			matrix_line << Node.new(diag)
		end
		path_matrix << matrix_line
	end
	return path_matrix
end

def parse_data(right, down)
	elem_count = 0
	matrix = []
	down.split("\n").each do |line|
		node_line = []
		line.split(" ").each do |value|
			node = Node.new(value.to_i)
			node_line << node
		end
		elem_count = line.split(" ").length
		matrix << node_line
	end

	last_line = []
	elem_count.times { |_| last_line << Node.new }
	matrix << last_line

	right.split("\n").each_with_index do |line, row_index|
		line.split(" ").each_with_index do |value, column_index|
			matrix[row_index][column_index].right = value.to_i
		end
	end

	return matrix
end

def fill_top_line(path_matrix)
	path_matrix.first.each_with_index do |node, index|
		break if index == path_matrix.first.length-1
		path_matrix.first[index+1].value = node.value + node.right
		path_matrix.first[index+1].path = 2
	end
	return path_matrix
end

def fill_left_column(path_matrix)
	path_matrix.each_with_index do |row, index|
		break if index >= path_matrix.length-1
		path_matrix[index+1].first.value = row.first.value + row.first.down
		path_matrix[index+1].first.path = 1
	end
	return path_matrix
end

def count_for_position(path_matrix, row_index, column_index)
	left_node = path_matrix[row_index][column_index-1]
	up_node = path_matrix[row_index-1][column_index]
	diag_node = path_matrix[row_index-1][column_index-1]
	node = path_matrix[row_index][column_index]
	left_score = left_node.value + left_node.right
	up_score = up_node.value + up_node.down
	diag_score = diag_node.value + diag_node.diag

	max_score = [diag_score, up_score, left_score].max
	max_path = [diag_score, up_score, left_score].index(max_score)

	node.value = max_score
	node.path = max_path

end

def fill_matrix(path_matrix)
	path_matrix = fill_top_line(path_matrix)
  path_matrix = fill_left_column(path_matrix)
	path_matrix.each_with_index do |row, row_index|
		next if row_index == 0
		row.each_with_index do |_, column_index|
			next if column_index == 0

			count_for_position(path_matrix, row_index, column_index)

		end
	end
	return path_matrix
end

def back_track(path_matrix, up_string, left_string)
	current_row_index = path_matrix.length-1
	current_column_index = path_matrix.first.length-1
	out_string = ""
	while current_row_index + current_column_index != 0
		#puts "#{current_row_index} : #{current_column_index}"
		node = path_matrix[current_row_index][current_column_index]
		if node.path == 0
			out_string += left_string.split("")[current_row_index-1]
			current_column_index -= 1
			current_row_index -= 1
		elsif node.path == 1
			current_row_index -= 1
		elsif node.path == 2
			current_column_index -= 1
		end
	end
	puts "#{out_string.reverse}"
end

def print_matrix(path_matrix)
	path_matrix.each do |line|
		puts "#{line.map(&:path)}"
	end
end
up_string = "CAAAATTAGCTTGCGTGTGAAAGGGGGCTCGGAGATCGGGGGTTTTCACTGGCGCGCATAGAACAACCGCTGAAAAGAGAACTCCACCGCGGTCGGTTAGGGGTCCTACTTGGAGGATTGCATATCGGTGTCAGCTTCTACGCGTGATGTAGTTTTTGGGGGCAGGAAATATTGTGGGGATCAGCTCGGATCGGAGAAAGATTTCACTGCGCTGGTTGGAATGCTATTGTCACATCACGGTGGCGTGTTCACCTCGATACCGACGCCCCGCTAAATGCTACTGCAATTCTCCACATGTAAATAAGGACTACCGAGCTTGGACGAACGCACGTCGTAATGCCCAGATCTCCTTTACTGCGTTGCTGGATCCACGTGGTGGGGCGTGGAAGATGCCAAAAGTGGTTCTGGCAATTGGCAGGATCTCGGGGGCATAAGAATGGCATAATCAGGAGTACCTGTCGCCTCAAGCTCATCATAACCAAGGGAACAATTATTAGTGGACGCACCTACGTGCGGAATAGCCCTGCCTAAGTCCTGTGCGCGGTAGGGTTACTTCTTGCTCGTCTCAAGGCATTCCGTGGTCCTTGGTATGAGTACGAGTAGCTCTAATACTCAAAGAGTGTAATGGGGAACGAAATTCTTAGTAAATTCCTGTCAGTAGCGTATAGATCCATCCAGCGCCTCGGTGCCGCGCGCGGATAGTGCCGCTCCTGGACCAGCACGCGCTTGCAAGGAAGCACTGCTTGATCTTGCACTCCGCCGCTTGTGACAAGTTGGGGTGCCCCAGCCCGATCGTGTCAGATGCATTGCCACCAACAATTTGCCCCAGTAGCGGACGACATCACCTGTAAGCCCTCACGATGTCACCAAGTGCATCAAGTCATCTTGCAGCAAGGCTTGATGAATTCCACCGGAGTTCCCTAAGACCTCACAGGTTTCTAATTTGGTTGATCTTTGC"
left_string = "AAACTAGTGCCATCAGAGCAAACGATGCGGTTCGCTTGACTCCGAAACGATTTCTTGTCCTCCAAACACGAAGACGACACGATAATTGACGAAACAGTATCAACTCGGCGTGACCTCTCCCCGTTGGTACCGGCGTCCGTGGCATGGTAGCAAGGCTAAAGCAAAAGTGGGCCTTGTGACCGACGCTAGGTAGCGCCTACGGCACCGGCGCCATATCTATAAGTTACATGTGTCCGGATATTGTTGTTCAATACTAGGTATACAACATAATGAAATAGCTACGTTTAGTGCGACTATCTAAGCCACATCAAAGTGACTCGTGTCGACAGTATAATAGTTATAATTACGTCCCCTCCTGTCTTCACACCGTTACCACCCGATAGCAGCCCTAAAGGCTTAGGACATGGAAGTGTGCCCGGAGGTCCGGGAAAATTACGCGTACGGCTGCAAACTGTATCCAGTTATGGTGGTCCTCCTATTCCCCCCGACCATCTATAAGACCCAGAATGAGATACTGCGTAAAATACCGCTACCGTTATGGGTATAACTTTCTCACTCCTGAGCGAAAGTATTACTTCGAGGGCGTGCTTCCAGGGCATCACCTAGGGGACCCCCCTCATCACTATCCTGACCAAGCACGCATGAAACTCTGCCCAATGAATCGCCACGCCAGCAAAGGGCCTATAGAATGTATAGGGGAGCTTCATGAGTGATCCGTTTACCATCTGTTTAGTTCCTTACTATAACGTTGCATACGTCAGGGAGATTATGTAGGTACATGCCTGTTCTGACTGTGATTGCACCCTGTACGGCAAAATTATCCAAAGGCTGCCTCTGATA"

path_matrix = form_path_matrix_by_strings(up_string, left_string)
path_matrix = fill_matrix(path_matrix)
back_track(path_matrix, up_string, left_string)
#print_matrix(path_matrix)