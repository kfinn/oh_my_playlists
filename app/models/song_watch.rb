class SongWatch < ApplicationRecord
  belongs_to :playlist_watch
  has_many :artist_watch_song_watches, inverse_of: :song_watch
  has_many :artist_watches, through: :artist_watch_song_watches

  after_create -> { delay.generate_artist_watches }

  private

  def track
    @track ||= RSpotify::Track.find(spotify_track_id)
  end

  def generate_artist_watches
    generated_artist_watches = track.artists.map do |artist|
      ArtistWatch
        .find_or_initialize_by(spotify_artist_id: artist.id)
        .tap { |artist_watch| artist_watch.name = artist.name }
    end

    generated_artist_watch_song_watches = generated_artist_watches.map do |artist_watch|
      artist_watch_song_watches.find_or_initialize_by(artist_watch: artist_watch)
    end

    outdated_artist_watch_song_watches = artist_watch_song_watches - generated_artist_watch_song_watches

    transaction do
      update! artist_watch_song_watches: generated_artist_watch_song_watches
      outdated_artist_watch_song_watches.each(&:destroy)
    end
  end
end
