#GRPH
require_relative "read_fasta.rb"
require "matrix"

class OverlapGraphs

	attr_accessor :sequences

	def initialize(sequences)
		@sequences = sequences
	end

	def check_compability(str1, str2)
		return str2.start_with?(str1[-3..-1]) ? true : false
	end

	def compare_sequences
		@sequences.keys.each_with_index do |key, index|
			@sequences.keys.each_with_index do |sub_key, sub_index|
				unless sub_index == index
					if check_compability(@sequences[key],@sequences[sub_key])
						puts "#{key} #{sub_key}"
					end
				end
			end
		end

	end

end

fasta = ReadFasta.new("fasta.txt")
fasta.parse
graphs = OverlapGraphs.new(fasta.result)
graphs.compare_sequences
