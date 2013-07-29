class HomeController < ApplicationController
  def index
    @header_section = :new

    @songbooks = []
    Songbook.find_each do |sb|
      @songbooks << {
        name: sb.name,
        new_tracks: sb.entries.order(:created_at).take(5)
      }
    end
  end
end