# http://www.graph-magics.com/articles/euler.php

graph = "0 -> 2
1 -> 3
2 -> 1
3 -> 0,4
6 -> 3,7
7 -> 8
8 -> 9
9 -> 6
"

def parse_graph(graph_str)
	nodes = Hash.new { |hash, key| hash[key] = [] }
	graph_str.split("\n").each do |node_data|
		data = node_data.split(" -> ")
		node_id = data[0].to_i
		conns_ids = data[1].split(",").map(&:to_i)
		conns_ids.each do |conn_id|
			nodes[node_id] << conn_id
		end
	end
	return nodes
end

def get_start_node(nodes)
	nodes.keys.each do |node_id|
		out_degree = nodes[node_id].length
		in_degree = nodes.keys.map { |in_node_id| nodes[in_node_id].index(node_id) }.compact.length
		return node_id if out_degree > in_degree
	end
end

def find_path(nodes)
	edges = [get_start_node(nodes)]
	result = []

	while !edges.empty?
		last_edge = edges.last
		result << edges.pop && next if !nodes.keys.include?(last_edge)
		out_nodes = nodes[last_edge]
		if !out_nodes.empty?
			edge = out_nodes.first
			nodes[last_edge].delete_at(0)
			edges << edge
		else
			result << edges.pop
		end
	end

	return result.reverse.join("->")
end

nodes = parse_graph(graph)
puts "#{find_path (nodes)}"