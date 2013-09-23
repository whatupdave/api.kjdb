class TracksController < ApplicationController
  def show
    @artist = Artist.find_by(slug: params[:artist_id])
    @album = @artist.albums.find_by(slug: params[:album_id])
    @track = @album.tracks.find_by(slug: params[:id])
    
    @tracks = @artist.tracks.order(:name)
  end
end