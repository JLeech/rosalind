
def hamming_distance(sample, pattern)
	distance = 0
	pattern.length.times do |index|
		distance += 1 if sample[index] != pattern[index]
	end
	return distance
end

def get_motifs(samples, motif_size)
	motifs = {}
	samples.each do |sample|
		for place in (0..(sample.length - motif_size)) do
			motifs[ sample[place..(place + motif_size)] ] = 0
		end
	end
	return motifs
end

