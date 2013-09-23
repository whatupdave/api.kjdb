class Track < ActiveRecord::Base
  belongs_to :album

  delegate :artist, :to => :album

  def to_param
    slug
  end
end