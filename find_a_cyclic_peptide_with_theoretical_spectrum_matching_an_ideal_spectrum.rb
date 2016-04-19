require_relative "calc_protein_mass"
require_relative "generate_the_theoretical_spectrum_of_a_cyclic_peptide"

def cyclopeptide_sequencing(spectrum)
	chosen_epeptides = []
	numeric_spectrum = spectrum.split(" ").map(&:to_i)
	peptides = ProteinMassCalculator::SIMPLE_MASS_TABLE.keys
	included_peptides = []
	while !peptides.empty?
		included_peptides = peptides.delete_if { |peptide| !numeric_spectrum.include? ProteinMassCalculator.calculate_mass(peptide) } 
		included_peptides.each_with_index do |peptide,index|
			theor_spectrum = get_theoretical_spectrum(peptide)
			if numeric_spectrum == theor_spectrum
				puts ProteinMassCalculator.prot_to_spectrum(peptide)
				included_peptides.delete_at(index)
			end
		end
		#cleared_peptides = included_peptides.delete_if { |pep| numeric_spectrum == get_theoretical_spectrum(pep) }
		peptides = expande_peptide(peptides)
		puts "step finished"
		puts "C: #{included_peptides.count}"

		break if peptides.first.length > 15
	end
	
end

def expande_peptide(peptides = [])
	expanded_peptides = []
	peptides.each do |peptide|
		ProteinMassCalculator::SIMPLE_MASS_TABLE.keys.each do |key|
			expanded_peptides << peptide + key
		end
	end
	return expanded_peptides
end

cyclopeptide_sequencing("71 97 99 103 113 113 114 115 131 137 196 200 202 208 214 226 227 228 240 245 299 311 311 316 327 337 339 340 341 358 408 414 424 429 436 440 442 453 455 471 507 527 537 539 542 551 554 556 566 586 622 638 640 651 653 657 664 669 679 685 735 752 753 754 756 766 777 782 782 794 848 853 865 866 867 879 885 891 893 897 956 962 978 979 980 980 990 994 996 1022 1093")