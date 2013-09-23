require 'sluggify'

class UpdateTrackInfoForEntry
  include Sidekiq::Worker

  sidekiq_options throttle: { threshold: 650, period: 1.hour } # rdio limit

  def perform(songbook_entry_id)
    entry = SongbookEntry.find(songbook_entry_id)
    return if entry.track_id?

    if rdio_track = Rdio::Track.search("#{entry.artist} #{entry.title}").first
      artist = rdio_track.artist.name.to_s
      album = rdio_track.album.name.to_s
      release_date = rdio_track.album.release_date
      track_name = rdio_track.name.to_s

      puts "Rdio: #{artist}(#{album} – #{release_date}) – #{track_name}"

      track = find_or_create_track(artist, album, release_date, track_name)

      entry.track = track
      entry.save!
    else
      puts "NOT FOUND #{track.artist} – #{track.title}"
    end
  end

  def find_or_create_track(artist_name, album_name, release_date, track_name)
    artist = Artist.where(slug: artist_name.sluggify, name: artist_name).first_or_create!

    album = artist.albums.find_by(slug: album_name.sluggify)
    if album.nil?
      album = artist.albums.create!(slug: album_name.sluggify, name: album_name, release_date: release_date)
    end

    track = album.tracks.find_by(slug: track_name.sluggify)
    if track.nil?
      album.tracks.create!(slug: track_name.sluggify, name: track_name)
    end

    track
  end
end