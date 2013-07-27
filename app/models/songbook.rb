class Songbook < ActiveRecord::Base
  has_many :entries, class_name: 'SongbookEntry'
end