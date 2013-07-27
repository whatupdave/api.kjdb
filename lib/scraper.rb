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
    attr_reader :slug
    attr_reader :block

    def initialize(slug, &block)
      @slug = slug
      @block = block
    end

    def scrape!
      Tracks.new(&@block)
    end
  end

  def self.scrape(name, &blk)
    @scrapes ||= []
    @scrapes << Scrape.new(name, &blk)
  end

  def self.all
    @scrapes
  end

  def self.find(slug)
    @scrapes.find{|s| s.slug == slug }
  end
end

Dir[File.dirname(__FILE__) + '/scrapers/*.rb'].each {|file| require file }