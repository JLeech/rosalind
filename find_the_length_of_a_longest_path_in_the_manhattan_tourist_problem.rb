class Node
	
	attr_accessor :right
	attr_accessor :down
	attr_accessor :value

	def initialize(down = 0)
		self.down = down
		self.right = 0
		self.value = 0
	end

end

right = "4 1 0 2 3 0 0 2 0 2 2 0 1 0
3 1 4 4 0 2 4 0 4 2 3 4 1 2
1 2 2 1 2 1 2 0 3 0 4 4 2 3
2 1 2 4 1 1 0 3 1 2 0 3 2 3
1 0 1 4 1 3 2 1 1 1 0 2 0 0
2 3 0 2 4 1 3 2 0 1 3 1 2 0
2 3 4 3 0 4 2 3 3 1 0 4 2 2
3 1 4 1 2 2 2 0 4 2 0 4 2 3
4 1 4 0 0 1 3 2 0 3 1 1 2 1
1 0 3 3 0 3 4 0 2 1 4 4 3 0
3 1 4 0 1 0 4 3 1 2 2 4 1 3
"

down = "1 0 4 1 3 1 2 1 1 1 3 2 4 3 1
0 2 0 1 4 3 4 0 3 0 4 3 2 1 3
3 4 4 0 2 4 4 1 0 1 2 2 4 3 2
4 3 2 4 0 2 1 0 0 2 3 1 0 1 0
0 3 3 2 4 0 3 0 3 0 0 2 2 0 0
2 3 3 0 0 3 4 1 2 1 0 3 2 0 4
3 2 0 3 4 3 3 3 0 2 0 3 3 1 0
4 2 3 3 3 0 3 3 3 0 1 3 1 4 1
0 0 1 3 1 3 2 0 1 0 0 3 3 0 2
2 2 1 4 1 1 1 0 1 2 0 3 1 2 3
"

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
	end
	return path_matrix
end

def fill_left_column(path_matrix)
	path_matrix.each_with_index do |row, index|
		break if index >= path_matrix.length-1
		path_matrix[index+1].first.value = row.first.value + row.first.down
	end
	return path_matrix
end


def count_for_position(path_matrix, row_index, column_index)
	left_node = path_matrix[row_index][column_index-1]
	up_node = path_matrix[row_index-1][column_index]
	node = path_matrix[row_index][column_index]
	
	left_score = left_node.value + left_node.right
	up_score = up_node.value + up_node.down

	node.value = up_score > left_score ? up_score : left_score

end

def fill_matrix(path_matrix)
	path_matrix.each_with_index do |row, row_index|
		next if row_index == 0
		row.each_with_index do |_, column_index|
			next if column_index == 0

			count_for_position(path_matrix, row_index, column_index)

		end
	end
	return path_matrix
end

def print_matrix(path_matrix)
	path_matrix.each do |line|
		puts "#{line.map(&:value)}"
	end
end

path_matrix = parse_data(right, down)
path_matrix = fill_top_line(path_matrix)
path_matrix = fill_left_column(path_matrix)
path_matrix = fill_matrix(path_matrix)
print_matrix(path_matrix)
puts path_matrix.last.last