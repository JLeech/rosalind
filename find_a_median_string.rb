def get_k_meres(k)
	"ATGC".split("").repeated_permutation(k).to_a.map(&:join).sort
end

def hamming_distance(sample, pattern)
	distance = 0
	pattern.length.times { |index| distance += 1 if sample[index] != pattern[index] }
	return distance
end

def get_all_k_meres(sample, k_mere_length)
	k_meres = Hash.new { |hash, key| hash[key] = 0 }
	(0..sample.length-k_mere_length).each do |sub_sample|
		k_meres[sample[sub_sample,k_mere_length]] = 1
	end
	return k_meres.keys
end

def get_min_hamming_for_dna(k_mere, dna)
	dna_kmeres = get_all_k_meres(dna, k_mere.length)
	return dna_kmeres.map { |dna_k_mere| hamming_distance(dna_k_mere, k_mere) }.min
end

def find_median_string(data, k_mere_length)
	k_meres = get_k_meres(k_mere_length)
	min_k_mere = ""
	min_score = 99999999
	k_meres.each do |k_mere|
		k_mere_score = data.map{ |dna| get_min_hamming_for_dna(k_mere, dna)}.inject(:+)
		if k_mere_score < min_score
			min_k_mere = k_mere
			min_score = k_mere_score 
		end
	end
	return min_k_mere
end


data = [
"GCTTGGCATTGCGAGACCAGGCATCGCTTGCACCCTAATGCC",
"AGTCATTGGTTTTGACCGAGCTTTTGTGTTAACCGACAACCT",
"ATCTCTCCTCGTACCGACCCCGGAAGCCATAAGAGGCAGTTA",
"CCTCAGGTGGGCGCATTAGGAATGCCACGTACAAAAAGCCAT",
"AGCCATACGAACATATAATCGTCAATAGATCATCCCTTTTTA",
"TTTACTCGACCTACGTGGCTAGTTAGGCATACTATCACGCCC",
"ATAAGTCAATGGCAAGACGGCATGTGGGTTAACACCAGCCAT",
"TACCTGTGTGAAGAACCGCTTTCTAGCCATTAGTTCTGAGGT",
"CTGTAAATATGAGGGTCGAGACATACCCCTGGAAGCTAATAC",
"GCCGAAGAAGACCCTGACAGTTAAAGGCATGATTCCGGTTTC"
]


puts find_median_string(data, 6)