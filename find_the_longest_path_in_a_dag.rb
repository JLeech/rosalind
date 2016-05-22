class Node
	
	attr_accessor :out_nodes
	attr_accessor :number

	def initialize(number)
		self.number = number
		self.out_nodes = []
	end

end

class Connections

	attr_accessor :out
	attr_accessor :to
	attr_accessor :weight

	def initialize(out, to, weight)
		self.out = out
		self.to = to
		self.weight = weight
	end

end

graph = "0->1:7
0->2:4
2->3:2
1->4:1
3->4:3"

def make_graph(graph)
	graph.split("\n").each do |graph_part|
		
	end

end