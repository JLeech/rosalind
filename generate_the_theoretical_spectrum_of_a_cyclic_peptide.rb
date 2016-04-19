require_relative "calc_protein_mass"


def get_theoretical_spectrum(peptide)
	subpeptides = Hash.new { |hash, key| hash[key] = 0 }
	combinations = circular_combinations(peptide)
	indices = (0...(combinations.first.length-1)).to_a
	indices.product(indices).reject{ |i,j| i > j }.each do |i,j|
		subpeptides[combinations.first[i..j]] += 1
	end

	combinations.each do |circular_peptide| 
		indices = (0...(circular_peptide.length-1)).to_a
  		indices.product(indices).reject{ |i,j| i > j }.each do |i,j|
  			subpeptides[circular_peptide[i..j]] = 1 if subpeptides[circular_peptide[i..j]] == 0
  		end
  		break
	end
	subpeptides[peptide] = 1
	result = []
	subpeptides.each do |subpeptide, places| 
		places.times { result << ProteinMassCalculator.calculate_mass(subpeptide) }
	end
	return result.sort
end

def circular_combinations(peptide)
	peptide_chars = peptide.split("")
	circular_combinations = []
	peptide.length.times { |iter| circular_combinations << peptide_chars.rotate(iter).join  }
	return circular_combinations
end

#print get_theoretical_spectrum("YNLFDSLPWMLDLC")
