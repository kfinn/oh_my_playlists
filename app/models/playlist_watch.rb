class PlaylistWatch < ApplicationRecord
  belongs_to :subscriber
  has_many :song_watches, inverse_of: :playlist_watch
  has_many :artist_watches, -> { distinct }, through: :song_watches
  has_many :artist_appearances, through: :artist_watches

  has_many :playlist_snapshots, inverse_of: :playlist_watch
  belongs_to :playlist_snapshot

  delegate :name, :tracks, to: :playlist

  validates :spotify_playlist_id, presence: true, uniqueness: true
  validate :playlist_must_exist, if: -> { spotify_playlist_id.present? }

  after_create -> { delay.refresh_song_watches! }

  def playlist_must_exist
    return if playlist.present?
    errors[:spotify_playlist_id] << 'must match a spotfy playlist'
  end

  def spotify_playlist_url
    playlist.external_urls['spotify']
  end

  def playlist_snapshot_completed!
    delay.update_song_watches_from_completed_playlist_snapshot!
  end

  def summary
    if artist_watches.empty?
      'no artists'
    elsif artist_watches.size <= 5
      artist_watches.map(&:name).to_sentence
    else
      first_artist_watch_names = artist_watches.first(5).map(&:name)
      (first_artist_watch_names + ["#{artist_watches.size - 5} more..."]).to_sentence
    end
  end

  private

  def playlist
    @playlist ||= RSpotify::Playlist.find_by_id(spotify_playlist_id)
  end

  def refresh_song_watches!
    playlist_snapshots.create!
  end

  def update_song_watches_from_completed_playlist_snapshot!
    latest_completed_playlist_snapshot = playlist_snapshots.completed.latest
    return if playlist_snapshot == latest_completed_playlist_snapshot

    outdated_playlist_snapshot = playlist_snapshot

    generated_song_watches =
      latest_completed_playlist_snapshot
      .playlist_snapshot_tracks
      .map do |playlist_snapshot_track|
        song_watches.find_or_initialize_by(spotify_track_id: playlist_snapshot_track.spotify_track_id)
      end
    outdated_song_watches = song_watches - generated_song_watches

    transaction do
      update!(
        playlist_snapshot: latest_completed_playlist_snapshot,
        song_watches: generated_song_watches
      )

      outdated_playlist_snapshot&.destroy!
      outdated_song_watches.each(&:destroy!)
    end
  end
end
