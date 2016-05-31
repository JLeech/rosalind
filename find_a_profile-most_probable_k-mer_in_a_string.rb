def get_all_k_meres(sample, k_mere_length)
	k_meres = Hash.new { |hash, key| hash[key] = 0 }
	(0..sample.length-k_mere_length).each do |sub_sample|
		k_meres[sample[sub_sample,k_mere_length]] = 1
	end
	return k_meres.keys
end

def get_probability(probability)
	prog_hash = {}

	prog_hash["A"] = probability[0].split(" ").map(&:to_f)
	prog_hash["C"] = probability[1].split(" ").map(&:to_f)
	prog_hash["G"] = probability[2].split(" ").map(&:to_f)
	prog_hash["T"] = probability[3].split(" ").map(&:to_f)

	return prog_hash
end

def get_k_mere_prob_score(k_mere, probs)
	score = 1.0
	k_mere.chars.each_with_index do |char, index|
		score *= probs[char][index]
	end
	return score
end

def get_k_mere_with_max_prob(dna, probs, k)
	best_k_mere = ""
	best_score = -9999999
	k_meres = get_all_k_meres(dna, k)
	k_meres.each do |k_mere|
		k_mere_score = get_k_mere_prob_score(k_mere, probs)
		if k_mere_score > best_score
			best_k_mere = k_mere
			best_score = k_mere_score
		end
	end
	return best_k_mere
end

probs = [
	"0.321 0.179 0.143 0.25 0.393 0.321 0.321",
	"0.143 0.357 0.464 0.25 0.214 0.143 0.25",
	"0.286 0.214 0.143 0.286 0.25 0.321 0.179",
	"0.25 0.25 0.25 0.214 0.143 0.214 0.25"
]

puts get_k_mere_with_max_prob("CTCCGGTGTGAGTTTGCGACGTTGTATTCATGTTTTATTGATGGGCTCACAAGACGATGGGCTGCGAAGGGTCACCACCGATGCTACGGACCTTCGACTGGAGGATATTGCATAAAGGACGGCCTTGACAACACCCGCAACATTTCGTCAATCCGTGAGGAAGTCCTCACAAGCAATGCGCCGAGTCAGTTAACGGTGTA", get_probability(probs), 7)