Word.delete_all
Relationship.delete_all

file = File.open( APP_ROOT.join('db', 'seed', 'sample_seed.txt'), 'r' )


file.each do |line|
  prev_word = nil
  line.chomp.split(' ').each do |word_str|
    word = Word.find_or_create_by(word: word_str)
    prev_word.children << word if prev_word
    prev_word = word
  end
end