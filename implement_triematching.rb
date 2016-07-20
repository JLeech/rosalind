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


  def find_positions(text)
    current_node = self.root_node
    text.chars.each_with_index do |_, text_index|
      printf "#{text_index} " if check_include(text[text_index..-1])
    end
  end

  def check_include(text)
    current_node = self.root_node
    text.chars.each_with_index do |text_char, text_index|
      if current_node.connected[text_char].nil?
        
        if current_node.connected.empty?
          return true
        else
          return false
        end
      else
        current_node = current_node.connected[text_char]
        return true if (text_index == text.chars.length-1) && (current_node.connected.empty?)
      end
    end
    return false
  end

  def print
    root_node.print
  end

end

text = "CCCATCCTTCCTGCCTACTTTATTCTGTCCCAAGTCCCAAGTTCCAAGTGCCGAGTCCCCGAGACTTCAGAGGAACTGTCTACGGGGCTCTCGGCCCAAGTATCGAGTGACAAATGAGTGAAGATGCAAAAGTTAAAAGTTAATCTTGCAGTGCCGGTGGTCCCAAGTCCCAAGTGTCGGGGAATGATAAGTGATAAGTGCGTCACGTTATCTCGGCATCAGCCCACTAAGGGGTACGGCGTACGGCGTCGTTCTGTGCCGAGTGCCGAGTTTCAGCTTATCCTGATAAGTGATAAGTGAGGGATTGTCAAGTGACGCCACTACGAGGTACGGCGTTATGGGTACCTCTGACCAATGAAGCTGAGGTCCCGGCTTGTGAACGGTATTGTCTGTAAAAAGGTGACTCCTCTCAGCTGTGTCCGGGTATTGCACACAGACCGCGGCTCGTTGAAACAACTTTAGTCAACGGTGCCGAGTGCCGAGTTAAGTGATTTGCCGAAGTGTGCCATGGTGTGACACCTTGAATACCCTGGGTACGGCGTATGGATGACAAATGACAAATGTGGCTAGGTTCATTAGACCAGCTCTACTTTTGGCTCTCGGCCCGTTAATGGGGGCCTGCAGGCCACGGTACTCTCGTTTAATCGGGCACAGTGGCGAAGTCGTAGTGATGTATTATGGTCCCAAGTACCCGTCTCGTTTCCACCGTGGCGCAGGAGGGTGTTTTGCGTGACAAATGAAAGTTAAAGCCAGCTGACAAATGACAAATGACCCATCGCTTCAGATGCCGCAGACTTCAGTACGGCGTACGGCGTCCGAGTCAAACGGTGAAACGGTTACAGGCCTAAATAAACATATAGACTGTCCGAAAAGTTAACGCATCGTCGGAGGTGTAAAAGTTAAAAGTTAAGTA"

sequences = ["TGATAAGTG",
"GTCCCAAGT",
"GCTCTCGGC",
"GTGCCGAGT",
"AAAAGTTAA",
"GTACGGCGT",
"TGACAAATG"]


trie = Trie.new(sequences)
trie.construct_trie
trie.find_positions(text)

