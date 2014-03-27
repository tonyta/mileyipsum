file = File.open( APP_ROOT.join('db', 'seed', 'combined_lyrics_file.txt'), 'r' )

line_lengths = Hash.new(0)

file.each do |line|
  count = line.chomp.split(' ').count
  line_lengths[count] += 1 if count > 0
end

next_word_occurances = line_lengths.to_a.sort{|a,b| a[0] <=> b[0]}.map{|e| e[1]}

next_word_probabilities = next_word_occurances.map.with_index{|e,i| next_word_occurances.last(next_word_occurances.length-i).inject(:+)/next_word_occurances.inject(:+).to_f}
puts next_word_probabilities