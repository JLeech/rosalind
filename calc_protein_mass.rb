# prtm

class ProteinMassCalculator

	attr_accessor :protein_string
	attr_accessor :mass

	MASS_TABLE = { "A" =>  71,
				"C" =>  103,
				"D" =>  115,
				"E" =>  129,
				"F" =>  147,
				"G" =>  57,
				"H" =>  137,
				"I" =>  113,
				"K" =>  128,
				"L" =>  113,
				"M" =>  131,
				"N" =>  114,
				"P" =>  97,
				"Q" =>  128,
				"R" =>  156,
				"S" =>  87,
				"T" =>  101,
				"V" =>  99,
				"W" =>  186,
				"Y" =>  163 }

	SIMPLE_MASS_TABLE = { "A" =>  71,
				"C" =>  103,
				"D" =>  115,
				"E" =>  129,
				"F" =>  147,
				"G" =>  57,
				"H" =>  137,
				"I" =>  113,
				"K" =>  128,
				"M" =>  131,
				"N" =>  114,
				"P" =>  97,
				"R" =>  156,
				"S" =>  87,
				"T" =>  101,
				"V" =>  99,
				"W" =>  186,
				"Y" =>  163 }

	def initialize(protein_string)
		@protein_string = protein_string
	end

	def calculate_mass
		@mass = 0.0
		@protein_string.split("").each { |chr| @mass += MASS_TABLE[chr] }
		return @mass.round(3)
	end

	def self.prot_to_spectrum(prot)
		prot.split("").map {|chr| MASS_TABLE[chr] }.join("-")
	end

	def self.calculate_mass(protein_string)
		return protein_string.split("").map {|chr| MASS_TABLE[chr] }.inject(:+)
	end

end

#calc = ProteinMassCalculator.new("VETWAEQWAHPGTDYTQIHVTSWDQANAIYVFFKCVFQQPIKDDDENRTWWWIGQYYQDRDIAYMKDFYEYQFHSACQCNVWHRAASRMQPSSVRNDWIKMEKMQRYFATWFYIMGNKHGTAMFYHQTLQSFHNWTCPDHHEDRGFEFKFSSDRCPCMAGTTFLTREIGYADTKEYRHHLTPWYNYEETQANRRSWCLNDEWMWYSWLKKGFHMANCGRPEVNWSSDAHHFKPQYPCHNKVAESWNPEACNVTNRIKDHFMSASEIVQYQCSYGRIAWTLMVDNHHSDADPMGINGVHAWWWSNHRMMNNEIATRVNYEMMSNEEGPWRFPPVWKTGRSVYAWDLMMLCCLCLIDWKYGTMLPNSRIVKDGYKLYPEREEKLDCVHDHHKEHHDIEQFWTPRWMITGDVQKHSFMFAWYCHTQGIAWFCQKDHQRFPWNYRITACVGLTSTWPDKNPNELRFFSIGAIKREYSDLMFPDPKTVMGMMDRYIDPAFFWLCSHKCSCLPFCGVLEVFRNGIFFLNMPDDKEKLHTYTDNEHGGQMCLWRVYELHFSIKTKGDYFQHFAHFYWAHELADLAPRMEFFGPYDTFNLFAFKVGHYHEVCWFQNHLWEEDVYKDCDVQISCFGEQNRTCCHFIYVIAHVKDTSYVHPKKDALVSALRQALMYGINPDVHVEIDPAECSSCENYKKCEEPDAYLMTYIVMQMEPECANSKWKPNKRWWPGEPQPHGVPEEKCIIMLFDRHWLPLKISPMIWWHVWCWHRPVARAQTSRLVRWPRAWGMHQPSMKAPDIYYMWQDTKKRDSRVDYANSHGKWN")
#puts calc.calculate_mass