# PROT
class RnaToProt

	TRANS_TABLE = Hash[
		"UUU", "F"    ,  "CUU", "L" ,"AUU", "I",  "GUU", "V",
		"UUC", "F"    ,  "CUC", "L" ,"AUC", "I",  "GUC", "V",
		"UUA", "L"    ,  "CUA", "L" ,"AUA", "I",  "GUA", "V",
		"UUG", "L"    ,  "CUG", "L" ,"AUG", "M",  "GUG", "V",
		"UCU", "S"    ,  "CCU", "P" ,"ACU", "T",  "GCU", "A",
		"UCC", "S"    ,  "CCC", "P" ,"ACC", "T",  "GCC", "A",
		"UCA", "S"    ,  "CCA", "P" ,"ACA", "T",  "GCA", "A",
		"UCG", "S"    ,  "CCG", "P" ,"ACG", "T",  "GCG", "A",
		"UAU", "Y"    ,  "CAU", "H" ,"AAU", "N",  "GAU", "D",
		"UAC", "Y"    ,  "CAC", "H" ,"AAC", "N",  "GAC", "D",
		"UAA", "Stop" ,  "CAA", "Q" ,"AAA", "K",  "GAA", "E",
		"UAG", "Stop" ,  "CAG", "Q" ,"AAG", "K",  "GAG", "E",
		"UGU", "C"    ,  "CGU", "R" ,"AGU", "S",  "GGU", "G",
		"UGC", "C"    ,  "CGC", "R" ,"AGC", "S",  "GGC", "G",
		"UGA", "Stop" ,  "CGA", "R" ,"AGA", "R",  "GGA", "G",
		"UGG", "W"    ,  "CGG", "R" ,"AGG", "R",  "GGG", "G"]

	def self.dna_to_rna(data)
		return data.gsub("T","U")
	end

	def self.convert(data)
		current_position = 0
		result = ""
		data.length.times do
			triplet = data[current_position..(current_position+2)]
			current_position += 3
			amino = TRANS_TABLE[triplet]
			break if amino == "Stop"
			break if triplet == nil
			break if triplet.length < 3
			result += amino
		end
		return result
	end

	def self.reverse_complement(text)
		string = text
		reverse_pares = {"A"=>"T", "G"=>"C", "T"=>"A", "C"=>"G"}
		(0..(string.length-1)).each { |index| string[index] = reverse_pares[string[index]] }
		return string
	end

	def self.find_substring(substring, text)
		out = []
		text.length.times do |place|
			matching_string = text[place..(place+substring.length*3-1)]
			puts matching_string
			puts convert(dna_to_rna(matching_string)) 
			puts convert(dna_to_rna(reverse_complement(matching_string)))
			if (convert(dna_to_rna(matching_string)) == "MA") || (convert(dna_to_rna(reverse_complement(matching_string))) == "MA")
				out << text[place..(place+substring.length*3-1)]
			end
		end
		return out
	end

end

puts RnaToProt.find_substring("MA","ATGGCCATGGCCCCCAGAACTGAGATCAATAGTACCCGTATTAACGGGTGA")
