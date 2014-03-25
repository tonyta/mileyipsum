INDEX_URI = "http://www.azlyrics.com/m/mileycyrus.html"

# from cached index
lyrics_index = Nokogiri::HTML open(APP_ROOT.join('db', 'scrape', 'raw_html', 'index.html'))

lyrics_paths = lyrics_index.css('#listAlbum > a').map { |a| a.attributes['href'].value }

File.open(APP_ROOT.join('db', 'scrape', 'lyrics_uris.txt'), 'w+') do |f|
  lyrics_paths.each do |path|
    f.write Pathname(INDEX_URI).join('..', path).to_s + "\n"
  end
end

def write_lyric_file(lyric_page)
  name = lyric_page.title.match(/\s-\s(.*)/)[1].gsub(/[^\w\d]/, '').underscore
  File.open(APP_ROOT.join('db', 'scrape', 'lyrics', "#{name}.txt"), 'w+') do |f|
    f.write lyric_page.css("div[style='margin-left:10px;margin-right:10px;']").text
  end
end

def write_lyric_html(lyric_page)
  name = lyric_page.title.match(/\s-\s(.*)/)[1].gsub(/[^\w\d]/, '').underscore
  File.open(APP_ROOT.join('db', 'scrape', 'html', "#{name}.html"), 'w+') do |f|
    f.write lyric_page.to_html
  end
end

File.open(APP_ROOT.join('db', 'scrape', 'lyrics_uris_remain.txt')).each do |lyric_url|
  lyric_page = Nokogiri::HTML open(lyric_url.chomp)
  print lyric_url.chomp
  write_lyric_html(lyric_page)
  10.times do
    print '.'
    sleep(3)
  end
  puts
end

# lyric_page = Nokogiri::HTML open(APP_ROOT.join('db', 'scrape', 'raw_html', 'example_lyrics.html'))
# write_lyric_file(lyric_page)