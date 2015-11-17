class ReadFasta

	attr_accessor :file_data
	attr_accessor :result

	def initialize(file)
		@file_data = File.read(file)
		@result = {}
	end

	def parse
		splitted_data = file_data.split(">")
		array_data = splitted_data.map { |val| val.split("\n") }
		prepared_data = array_data.delete_if(&:empty?)
		prepared_data.each { |dna| @result[dna[0]] = dna[1..-1].join }
	end


end