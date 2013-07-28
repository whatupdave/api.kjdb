# encoding: utf-8

def stream_lines(url, &blk)
  uri = URI(url)

  Net::HTTP.get_response(uri) do |res|
    buf = ""
    res.read_body do |chunk|
      buf << chunk
      lines = buf.split("\n")
      lines[0...-1].each do |line|
        blk.call(line)
      end
      buf = lines[-1]
    end
  end
end

Scraper.scrape 'kj-paul' do
  artist, title = nil, nil
  stream_lines('http://kjpaul.com/files/tmp/KJPaulSongList.xml') do |line|
    if line =~ /Artist>(.*)<\/Artist/
      artist = $1.strip
    elsif line =~ /Title>(.*)<\/Title/
      title = $1.strip
      track artist: artist, title: title
    end
  end
end