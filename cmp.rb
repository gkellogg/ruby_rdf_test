require 'rdf'
require 'linkeddata'
require 'rdf/normalize'

file1 = "test1"
file2 = "test2"

puts "loading graphs"
graph1 = RDF::Graph.load(file1 + ".ttl")
graph2 = RDF::Graph.load(file2 + ".ttl")

puts "canon'ing graphs"
graphc1 = graph1.dump(:normalize)
graphc2 = graph2.dump(:normalize)

graphc1_triples = graphc1.split("\n")
graphc2_triples = graphc1.split("\n")
puts "|graphc1| = #{graphc1_triples.length}"
puts "|graphc2| = #{graphc2_triples.length}"

File.open("canon/" + file1 + ".nq", "w") { |f| f.write(graphc1) }
File.open("canon/" + file2 + ".nq", "w") { |f| f.write(graphc2) }

puts "\nmissing in graph2:"
miss2_cnt = 0
graphc1_triples.each do |triple|
    if !graphc2.include?(triple)
        miss2_cnt += 1
        puts triple
    end
end
puts "# missing in graph2: #{miss2_cnt}"

puts "\nmissing in graph1:"
miss1_cnt = 0
graphc2_triples.each do |triple|
    if !graphc1.include?(triple)
        miss1_cnt += 1
        puts triple
    end
end
puts "# missing in graph1: #{miss1_cnt}"
