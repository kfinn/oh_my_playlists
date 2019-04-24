class PlaylistWatch < ApplicationRecord
  belongs_to :subscriber
  has_many :song_watches, inverse_of: :playlist_watch
  has_many :artist_watches, through: :song_watches
  has_many :artist_appearances, through: :artist_watches

  delegate :name, to: :playlist

  validates :spotify_playlist_id, presence: true, uniqueness: true
  validate :playlist_must_exist, if: -> { spotify_playlist_id.present? }

  after_create -> { delay.generate_song_watches }

  def playlist_must_exist
    return if playlist.present?
    errors[:spotify_playlist_id] << 'must match a spotfy playlist'
  end

  def playlist
    @playlist ||= RSpotify::Playlist.find_by_id(spotify_playlist_id)
  end

  private

  def generate_song_watches
    generated_song_watches = playlist.tracks.map do |track|
      song_watches.find_or_initialize_by(spotify_track_id: track.id)
    end

    outdated_song_watches = song_watches - generated_song_watches

    transaction do
      update! song_watches: generated_song_watches
      outdated_song_watches.each(&:destroy)
    end
  end
end
