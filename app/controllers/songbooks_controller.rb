class SongbooksController < ApplicationController
  before_action :set_nav
  before_action :set_songbooks, only: [:index, :show]

  def show
    @songbook = Songbook.find_by!(slug: params[:id])
    @entries = @songbook.entries.joins(
      'LEFT JOIN "tracks" ON "tracks"."id" = "songbook_entries"."track_id" LEFT JOIN "albums" ON "albums"."id" = "tracks"."album_id" LEFT JOIN "artists" ON "artists"."id" = "albums"."artist_id"'
    ).order('artists.name, tracks.name, songbook_entries.artist, songbook_entries.title').take(10)
  end

  private

  def set_songbooks
    @songbooks = Songbook.order(:name)
  end

  def set_nav
    @header_section = :songbooks
  end
end