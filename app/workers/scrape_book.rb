require 'scraper'

class ScrapeBook
  include Sidekiq::Worker

  def perform(book_slug)
    scraper = Scraper.find(book_slug)
    songbook = Songbook.find_by!(slug: book_slug)

    puts "scraping #{songbook.name}"
    tracks = scraper.scrape!

    tracks.each do |track|
      entry = songbook.entries.find_by(artist: track.artist, title: track.title)
      if entry.nil?
        puts "New track #{track.artist} – #{track.title}"
        songbook.entries.create!(artist: track.artist, title: track.title)
      end
    end
  end
end