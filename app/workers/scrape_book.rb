# encoding: utf-8

require 'scraper'

class ScrapeBook
  include Sidekiq::Worker

  sidekiq_options :queue => :scrape

  def perform(book_slug)
    scraper = Scraper.find(book_slug)
    songbook = Songbook.find_by!(slug: book_slug)

    puts "scraping #{songbook.name}"

    scraper.scrape do |track|
      entry = songbook.entries.find_by(artist: track.artist, title: track.title)
      if entry.nil?
        puts "New track #{track.artist} - #{track.title}"
        songbook.entries.create!(artist: track.artist, title: track.title)
      end
    end
  end
end