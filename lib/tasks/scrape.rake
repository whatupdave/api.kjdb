require 'scraper'

namespace :scrape do
  task :all => :environment do
    Scraper.all.each do |scraper|
      ScrapeBook.perform_async(scraper.slug)
    end
  end

  task :update_tracks => :environment do
    SongbookEntry.where('track_id is null').find_each do |entry|
      UpdateTrackInfoForEntry.perform_async entry.id
    end
  end
end