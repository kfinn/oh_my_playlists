class SongWatch < ApplicationRecord
  belongs_to :playlist_watch
  has_many :artist_watch_song_watches, inverse_of: :song_watch
  has_many :artist_watches, through: :artist_watch_song_watches

  after_create -> { delay.generate_artist_watches }

  delegate :name, to: :track

  def spotify_track_url
    track.external_urls['spotify']
  end

  def spotify_artist_url_for_appearance(artist_appearance)
    spotify_artist = track.artists.find { |a| a.id == artist_appearance.artist_watch.spotify_artist_id }
    spotify_artist.external_urls['spotify']
  end

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
