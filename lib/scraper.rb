require 'nokogiri'
require 'open-uri'
require 'json'
require 'rdio'

module Scraper
  class Track < Struct.new(:artist, :title)
  end

  class Tracks
    include Enumerable

    def initialize(&blk)
      @tracks = []
      instance_eval(&blk)
    end

    def track(options)
      @tracks << Track.new(options[:artist].strip, options[:title].strip)
    end

    def each(&blk)
      @tracks.each(&blk)
    end
  end

  class Scrape
    attr_reader :name
    attr_reader :block

    def initialize(name, &block)
      @name = name
      @block = block
    end
  end

  def self.scrape(name, &blk)
    @scrapes ||= []
    @scrapes << Scrape.new(name, &blk)
  end

  def self.scrape_all
    @scrapes.each do |scrape|
      songbook = Songbook.find_by!(slug: scrape.name)

      puts "scraping #{songbook.name}"
      tracks = Tracks.new(&scrape.block)

      tracks.each do |track|
        entry = songbook.entries.find_by(artist: track.artist, title: track.title)
        if entry.nil?
          puts "New track #{track.artist} – #{track.title}"
          songbook.entries.create!(artist: track.artist, title: track.title)
        end
      end
    end
  end
end
