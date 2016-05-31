
class Node

	attr_accessor :id
	attr_accessor :conns
	attr_accessor :watched

	def initialize(id)
		self.id = id
		self.conns = []
		self.watched = []
	end

	def odd?
		return conns.length%2 == 0 ? true : false
	end

	def get_next
		while true
			return nil if self.watched.length == self.conns.length
			random_number = rand(self.conns.length)
			random_node = self.conns[random_number]
			if !self.watched.include? random_node.id
				self.watched << random_node.id
				return random_node
			end
		end
	end

	def clear_watched
		self.watched = []
	end

	def bridge?
		return true if conns.length == 0
		return false
	end

	def not_bridge?
		return !bridge?
	end


end

graph = "
"

def find_cycle(nodes)
	odd_nodes_ids = nodes.select(&:odd?).map(&:id)
	max_path = []
	path = []
	choise_map = Hash.new { |hash, key| hash[key] = [] }
	odd_nodes_ids.each do |current_node_id|
		cloned_nodes = nodes.clone
		current_node = cloned_nodes[current_node_id]
		while true
			not_bridge_node = current_node.conns.select(&:not_bridge?).first
			if not_bridge_node.nil?
				not_bridge_node = current_node.conns.first
				current_node.conns.delete_at(0)
				path << current_node
				current_node = not_bridge_node
				break if not_bridge_node.nil?
			else
				choise_map[current_node.id] << not_bridge_node.id
				current_node.conns.delete_if { |x| x.id == not_bridge_node.id}
				path << current_node
				current_node = not_bridge_node
			end
		end
		if path.length > max_path.length
			max_path = path
		end
		puts choise_map
		path = []
	end
	return max_path.map(&:id)
end

def find_cycle_by_random(nodes, connection_count)
	current_path = []
	while true
		nodes.each { |node| node.clear_watched }
		current_node = nodes[rand(nodes.length)]
		current_path = []
		while true
			break if current_node.nil?
			current_path << current_node
			current_node = current_node.get_next
		end
		break if connection_count == current_path.length-1
	end	
	return current_path.map(&:id)
end

def parse_graph(graph_str)
	nodes = []
	graph_str.split("\n").each do |node_data|
		data = node_data.split(" -> ")
		node_id = data[0].to_i 
		if nodes[node_id].nil?
			nodes[node_id] = Node.new(node_id)
		end
		conns_ids = data[1].split(",").map(&:to_i)
		conns_ids.each do |conn_id|
			if nodes[conn_id].nil?
				nodes[conn_id] = Node.new(conn_id)
			end
			nodes[node_id].conns << nodes[conn_id]
		end
	end
	return nodes
end

def count_connections(nodes)
	connections = 0
	nodes.each do |node|
		connections += node.conns.length
	end
	return connections
end

nodes = parse_graph(graph).compact

puts find_cycle_by_random(nodes, count_connections(nodes)).join("->")

