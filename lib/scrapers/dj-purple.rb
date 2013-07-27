# encoding: utf-8

Scraper.scrape 'dj-purple' do
  doc = Nokogiri::HTML(open('http://djpurple.com/blog/songbook/'))

  songs = doc.css('p').
    select{|el| el.text.include? ' – ' }.
    map{|el| el.text.gsub('’', "\'").split(' – ')}.
    map{|artist, title| [artist.gsub('“', '').strip, title.gsub('(duet)', '').strip] }

  songs.each do |artist, title|
    track artist: artist, title: title
  end
end