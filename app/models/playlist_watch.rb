class PlaylistWatch < ApplicationRecord
  belongs_to :subscriber

  delegate :name, to: :playlist

  validates :spotify_id, presence: true
  validate :playlist_must_exist, if: -> { spotify_id.present? }

  def playlist_must_exist
    return if playlist.present?
    errors[:spotify_id] << 'must match a spotfy playlist'
  end

  def playlist
    @playlist ||= RSpotify::Playlist.find_by_id(spotify_id)
  end
end
