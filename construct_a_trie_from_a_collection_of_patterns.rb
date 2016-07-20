class TrieNode

  attr_accessor :id
  attr_accessor :letter
  attr_accessor :connected

  def initialize(id = 0, letter = nil)
    self.id = id
    self.letter = letter
    self.connected = {}
  end

  def print
    self.connected.keys.each do |conn_key|
      connected_node = self.connected[conn_key]
      puts "#{self.id}->#{connected_node.id}:#{connected_node.letter}"
      connected_node.print
    end
  end

end

class Trie

  attr_accessor :sequences
  attr_accessor :root_node


  def initialize(sequences)
    self.sequences = sequences
    self.root_node = TrieNode.new()
  end

  def construct_trie
    current_id = 1
    self.sequences.each do |seq|
      current_node = root_node
      seq.chars.each do |seq_char|
        if current_node.connected[seq_char].nil?
           current_node.connected[seq_char] = TrieNode.new(current_id, seq_char)
           current_node = current_node.connected[seq_char]
           current_id += 1
        else
          current_node = current_node.connected[seq_char]
        end
      end 
    end
  end

  def print
    root_node.print
  end

end


sequences = ["ATCG","GGGT"]
text = "AATCGGGTTCAATCGGGGT"

trie = Trie.new(sequences)
trie.construct_trie
trie.print

