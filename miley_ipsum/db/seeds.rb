Word.delete_all
Relationship.delete_all

file = File.open( APP_ROOT.join('db', 'seed', 'combined_lyrics_file.txt'), 'r' )


file.each do |line|
  prev_word = nil
  line.chomp.split(' ').each do |word_str|
    word = Word.find_or_create_by(word: word_str)

    if prev_word && relationship = Relationship.find_by(child_id: word.id, parent_id: prev_word.id)
      relationship.update(count: relationship.count + 1)
    else
      prev_word.children << word if prev_word
    end
    prev_word = word
  end
end