def get_samples(sample,d)
	samples = {}
	samples[sample] = 0
	nucleotides = ["A","T","G","C"]
	places = (0..(sample.length-1)).to_a.permutation(d).to_a
	nucleo_samples = nucleotides.repeated_combination(d).to_a
	places.each do |current_places|
		nucleo_samples.each do |nucleo_sample|
			sample_copy = sample.dup
			current_places.length.times do |place|
				sample_copy[current_places[place]] = nucleo_sample[place]
			end
			samples[sample_copy] = 0
		end
	end
	return samples.keys
end

def get_all_k_meres(sample, k_mere_length)
	k_meres = Hash.new { |hash, key| hash[key] = 0 }
	(0..sample.length-k_mere_length).each do |sub_sample|
		k_meres[sample[sub_sample,k_mere_length]] += 1
	end
	return k_meres
end

def get_most_frequent_words_with_mistmatches(sample, k_mere_length, d)
	k_meres = get_all_k_meres(sample, k_mere_length)
	samples = Hash.new { |hash, key| hash[key] = 0 }
	k_meres.keys.each do |k_mere|
		get_samples(k_mere, d).each do |string_part|
			samples[string_part] += k_meres[k_mere]
		end
	end
	#max = samples.values.max
	#return samples.select { |k,v| v == max }.keys
	return samples.keys
end

def get_motivs(dnas,k,d)
	most_frequent = []
	dnas.each_with_index do |string, index|
		if index == 0
			most_frequent = get_most_frequent_words_with_mistmatches(string, k, d)
		else
			most_frequent = most_frequent & get_most_frequent_words_with_mistmatches(string, k, d)
		end
	end
	return most_frequent
end

data = [
"CACCGCAGGAAGACAATGCCAGCAC",
"CTACGTTTCTACCGTATAAACCACG",
"ACCACTTCTACGCCGCCTCGAAAGA",
"CCTCGAGACTCGCGACTCATTCGGC",
"CGGCGGCGGCCCACGGTGAGTCCCC",
"CCGGCCACCGCCAGTGGCTCATCTT",
"TCCAGGCAGTCAAGCCGTCGGCCTA",
"GCTGTCTGCGCTTTGATAGAGTCCC",
"CATAATACCCATACATTCAACTTCG",
"TTACCCTGTACTGCGTCCTGGCCCA"
]

k = 5
d = 2

puts "#{get_motivs(data, k, d).join(' ')}"
