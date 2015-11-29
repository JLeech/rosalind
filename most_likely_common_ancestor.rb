require_relative "read_fasta.rb"
require "matrix"

class MostLikelyCommonAncestor

	attr_accessor :sequences
	attr_accessor :profile_hash
	attr_accessor :consensus

	def initialize( sequences )
		@sequences = sequences
		@profile_matrix = { "A" => [], "C" => [], "G" => [], "T" => [] }
		@consensus = ""
	end

	def count_profile
		array_of_sequences = []
		@sequences.keys.each do |key|
			array_of_sequences.push(@sequences[key].split(""))
		end
		formated_matrix = Matrix.rows(array_of_sequences).transpose.to_a
		formated_matrix.each do |column|
			current_profiler = { "A" => 0, "C" => 0, "G" => 0, "T" => 0 }
			column.each do |nucleotide|
				current_profiler[nucleotide] += 1
			end
			@profile_matrix.merge!(current_profiler) { |key, old_val, new_val| old_val + [new_val] }
		end
	end

	def count_consensus
		seq_length = @profile_matrix[@profile_matrix.keys.first].length
		seq_length.times do |position|
			max_value = 0
			max_profile = ""
			@profile_matrix.keys.each do |key|
				if @profile_matrix[key][position] > max_value
					max_value = @profile_matrix[key][position]
					max_profile = key
				end
			end
			@consensus += max_profile
		end
		puts @consensus
	end

	def print_formated_profile_matrix
		@profile_matrix.keys.each do |key|
			puts "#{key}: #{@profile_matrix[key].to_s.sub('[','').sub(']','').gsub(',','')}"
		end
	end

end

fasta = ReadFasta.new("fasta.txt")
fasta.parse
most = MostLikelyCommonAncestor.new(fasta.result)
most.count_profile
most.count_consensus
most.print_formated_profile_matrix