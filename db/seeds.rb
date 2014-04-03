Word.delete_all
Relationship.delete_all

file = File.open( APP_ROOT.join('db', 'seed', 'combined_lyrics_file.txt'), 'r' )


file.each do |line|
  prev_word = nil
  words = line.chomp.split(' ')
  words.each_with_index do |word_str, index|
    word = Word.find_or_create_by(word: word_str)

    word.update(alpha: word.alpha + 1) if index == 0
    word.update(omega: word.omega + 1) if index == words.length - 1

    if prev_word && relationship = Relationship.find_by(child_id: word.id, parent_id: prev_word.id)
      relationship.update(count: relationship.count + 1)
    else
      prev_word.children << word if prev_word
    end
    prev_word = word
  end
end

alpha_array = Word.all.each.with_object([]) { |word, array|
  word.alpha.times { array << word.id }
}

alpha = File.open( APP_ROOT.join('db', 'seed', 'alpha.txt'), 'w+')
alpha.write alpha_array.to_s
