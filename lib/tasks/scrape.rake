require 'scrapers/dj-purple'

namespace :scrape do
  task :all => :environment do
    Scraper.scrape_all
  end

  task :update_tracks => :environment do
    SongbookEntry.where('track_id is null').find_each do |entry|
      UpdateTrackInfoForEntry.perform_async entry.id
    end
  end
end