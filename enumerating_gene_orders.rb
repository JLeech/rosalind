#perm

n = Array (1..6)
res = n.permutation(n.length).to_a

puts res.count
puts "#{res}"