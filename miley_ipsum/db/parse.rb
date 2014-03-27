def write_lyric_file(lyric_page)
  name = lyric_page.title.match(/\s-\s(.*)/)[1].gsub(/[^\w\d]/, '').underscore
  File.open(APP_ROOT.join('db', 'scrape', 'lyrics', "#{name}.txt"), 'w+') do |f|
    f.write lyric_page.css("div[style='margin-left:10px;margin-right:10px;']").text
  end
end

Dir[APP_ROOT.join('db', 'scrape', 'html', '*.html')].each do |file|
  page = Nokogiri::HTML( open(file) )
  write_lyric_file(page)
end

combined_lyrics_file = File.open(APP_ROOT.join('db', 'seed', 'combined_lyrics_file.txt'), 'w+')

Dir[APP_ROOT.join('db', 'scrape', 'lyrics', '*.txt')].each do |file|
  lyrics = File.open(file, 'r')
  lyrics.each do |line|
    sanitized_line = line.downcase.gsub(/(\[.*\])/, '').gsub(/[^\w\d\-' ]/, '')
    next unless sanitized_line =~ /\w/
    combined_lyrics_file.write "#{sanitized_line}\n"
  end
end

