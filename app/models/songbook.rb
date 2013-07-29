class Songbook < ActiveRecord::Base
  has_many :entries, class_name: 'SongbookEntry'

  def to_param
    slug
  end
end