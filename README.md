KJDB
====

    artist
      slug
      name

    album
      artist_id
      slug
      name

    track
      album_id
      slug
      title

    songbook
      title

    songbook_entry
      songbook_id
      title
      artist
      track_id (canonical)

      timestamps


    rdio_track
      song_id
      album_key
      artist_key
      album_url

    spotify_track
      song_id
      spotify_url

    youtube_track
      song_id



    venue
      venue_id
      address
      songbook_id?
      karaoke_bar (bool)

    kj
      kj_id
      schedule
      songbook_id?

    events
      event_id
      name
      venue_id
      kj_id?
      date (RECURRING? WTF. HALP)

    shows (venue or kj)
      slug
      name
      type (venue or kj)
