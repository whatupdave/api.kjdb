class SongbookEntry < ActiveRecord::Base
  belongs_to :songbook
  belongs_to :track
end