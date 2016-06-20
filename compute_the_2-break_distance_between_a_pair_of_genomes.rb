def data_to_array(data)
	return data.gsub("(","").gsub(")","").split(" ").map(&:to_i)
end

def get_cycles(dna)
	return dna.split(")(").map { |cycle| data_to_array(cycle) }
end

def get_graphs(data)
	return [get_cycles(data[0]) ,data.map{ |dna| get_cycles(dna) }.inject(:+)]
end

def compute_graph(dnas_cycles)
	graph = Hash.new { |hash, key| hash[key] = [] }
	dnas_cycles.each do |cycle|
		cycle_length = cycle.length
		cycle.each_with_index do |node_id, index|
			connected_node_id = -1*cycle[(index+1)%cycle_length]
			graph[node_id] << connected_node_id
			graph[connected_node_id] << node_id
		end
	end
	return graph
end

def compute_distance(p, dnas_cycles)
	graph = compute_graph(dnas_cycles)
	puts "#{graph}"
	components = 0
	nodes_ids = graph.keys
	puts "#{nodes_ids}"
    while !nodes_ids.empty?
    	components += 1
    	current_nodes = [nodes_ids.pop]
    	puts "#{current_nodes}"
    	while !current_nodes.empty?
    	 	current_nodes = current_nodes[0..-2] + graph[current_nodes.last] & nodes_ids
    		puts "C : #{current_nodes}"
    		nodes_ids -= current_nodes
    	end
    end
   
   return p.map(&:length).inject(:+) - components

end


data = [
	"(+1 +2 +3 +4 +5 +6)", "(+1 -3 -6 -5)(+2 -4)"
]
data = get_graphs(data)
puts compute_distance(data[0], data[1])
