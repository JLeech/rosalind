#ba1h

def hamming_distance(sample, pattern)
	distance = 0
	pattern.length.times do |index|
		distance += 1 if sample[index] != pattern[index]
	end
	return distance
end

def get_positions_with_fixed_hamming(sample, pattern, ham_distance)
	sample_positions = []
	position = 0
	while sample.length >= pattern.length
		sample_positions << position if hamming_distance( sample[0..(pattern.length-1)], pattern ) <= ham_distance
		sample = sample[1..-1]
		position += 1
	end
	return sample_positions
end

sample = "TCGGTCCTCGGAGCATGTGGTACAACGGATCCTAGAATCGGGCAAGCAAAGATTGCGCGCCTCGCTGCGCAGCAACCAGCTGTCCGTAGAAGGTGCCTGTACGTTGCTGCAGTGCCGGGAGAAACACATCGGGTGCGAGTCAGTTGGAGTTCGGGGAGCGACTCGTTGACGAGCGAAAGTCGGCTGAACATCGACGGGAGACAACAGATAGGAAGTCAGATCAGTGAAATCGGTCACCGCGCCCAAATCCTTAATGCCGAGGGCATCACTTGCGCCCGATGACAATGTCTATTCGCCTGACCAAGCACAAAGGATGTCGCAACGCGGGTG"
pattern = "TTGGAG"
dist = 2

puts get_positions_with_fixed_hamming(sample, pattern, dist).length