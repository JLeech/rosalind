
strings = [
"ACCGA",
"CCGAA",
"CGAAG",
"GAAGC",
"AAGCT"
]

result = strings[0] + strings[1..-1].map{ |str| str[-1] }.join()

puts result