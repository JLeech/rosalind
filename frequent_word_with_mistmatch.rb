# ba1i

def hamming_distance(sample, pattern)
	distance = 0
	pattern.length.times do |index|
		distance += 1 if sample[index] != pattern[index]
	end
	return distance
end

def get_samples(sample,d)
	samples = Hash.new { |hash, key| hash[key] = 0 }
	nucleotides = ["A","T","G","C"]
	places = (0..(sample.length-1)).to_a.permutation(d).to_a
	nucleo_samples = nucleotides.repeated_combination(d).to_a

	places.each do |current_places|
		nucleo_samples.each do |nucleo_sample|
			sample_copy = sample.clone
			current_places.length.times do |place|
				sample_copy[current_places[place]] = nucleo_sample[place]
			end
			samples[sample_copy] = 0
		end
	end

	return samples.keys
end

def get_most_frequent_k_meres(k_meres, sample, ham_distance)
	frequent_k_meres = Hash.new { |hash, key| hash[key] = 0 }
	k_mere_length = k_meres.first.length
	while sample.length >= k_mere_length
		k_meres.each do |k_mere|
			frequent_k_meres[k_mere] += 1 if hamming_distance(sample[0..(k_mere_length-1)], k_mere) <= ham_distance
		end
		sample = sample[1..-1]
	end
	return frequent_k_meres
end

def get_k_meres(k)
	"ATGC".split("").repeated_permutation(k).to_a.map(&:join).sort
end

text = "CACAGTAGGCGCCGGCACACACAGCCCCGGGCCCCGGGCCGCCCCGGGCCGGCGGCCGCCGGCGCCGGCACACCGGCACAGCCGTACCGGCACAGTAGTACCGGCCGGCCGGCACACCGGCACACCGGGTACACACCGGGGCGCACACACAGGCGGGCGCCGGGCCCCGGGCCGTACCGGGCCGCCGGCGGCCCACAGGCGCCGGCACAGTACCGGCACACACAGTAGCCCACACACAGGCGGGCGGTAGCCGGCGCACACACACACAGTAGGCGCACAGCCGCCCACACACACCGGCCGGCCGGCACAGGCGGGCGGGCGCACACACACCGGCACAGTAGTAGGCGGCCGGCGCACAGCC"
k_mere_length = 10
distance = 2

k_meres = get_k_meres(k_mere_length)


frequence = get_most_frequent_k_meres(k_meres, text, distance)
max_frequence = frequence.values.max
puts  Hash[ frequence.select {|k,v| v == max_frequence} ].keys.join(" ")

# text = "ACGTTGCATGTCGCATGATGCATGAGAGCT"
# k_length = 4
# dist = 1


# puts get_samples("GAGGTCGGG",3)

# def get_permutations(sample, d, samples)
# 	nucleotides = ["A","T","G","C"]
# 	sample.length.times do |index|
# 		nucleotides.each do |nucleo|
# 			new_sample = sample.clone
# 			new_sample[index] = nucleo
# 			samples[new_sample] = 0	
# 		end
# 	end

# 	return samples
# end
