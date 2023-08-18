require 'rdf'
require 'linkeddata'
require 'rdf/ntriples'

file1 = "test1.ttl"
file2 = "test2.ttl"

puts "loading graphs"
graph1 = RDF::Graph.load(file1)
graph2 = RDF::Graph.load(file2)

puts "canon'ing graphs"
graphc1 = graph1.canonicalize()
graphc2 = graph2.canonicalize()

puts "|graphc1| = " + graphc1.count().to_s
puts "|graphc2| = " + graphc2.count().to_s

File.open("canon/" + file1, "w") { |f| f.write(graphc1.dump(:ntriples)) }
File.open("canon/" + file2, "w") { |f| f.write(graphc2.dump(:ntriples)) }

puts "\nmissing in graph2:"
miss2_cnt = 0
graph1.each_statement do |stmt|
    if !graph2.statement?(stmt)
        miss2_cnt += 1
        puts stmt
    end
end
puts "# missing in graph2: " + miss2_cnt.to_s

puts "\nmissing in graph1:"
miss1_cnt = 0
graph2.each_statement do |stmt|
    if !graph1.statement?(stmt)
        miss1_cnt += 1
        puts stmt
    end
end
puts "# missing in graph1: " + miss1_cnt.to_s