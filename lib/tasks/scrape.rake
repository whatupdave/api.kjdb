require 'scrapers/dj-purple'

namespace :scrape do
  task :all => :environment do
    Scraper.scrape_all
  end
end