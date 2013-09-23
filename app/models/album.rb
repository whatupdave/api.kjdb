class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks
  
  def to_param
    slug
  end
end