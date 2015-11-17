#splc
#Дана последовательность в гене, необходимо выделить из неё экзоны, и оттранслировать полученную последовательность в белок
require_relative "read_fasta"
require_relative "rna_to_prot"
require_relative "dna_to_rna"

data = ReadFasta.new("fasta.txt")
data.parse
sequences = data.result

main_seq = sequences[sequences.keys.first]

sequences.keys[1..-1].each do |key|
	main_seq.sub!(sequences[key],"")
end

converted = RnaToProt.convert( DnaToRna.convert(main_seq))

puts converted

