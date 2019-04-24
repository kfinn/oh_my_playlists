class PlaylistSnapshotPage < ApplicationRecord
  belongs_to :playlist_snapshot
  has_many :playlist_snapshot_tracks, inverse_of: :playlist_snapshot_page, dependent: :destroy
  has_one :playlist_watch, through: :playlist_snapshot

  delegate :tracks, to: :playlist_watch

  scope :complete, -> { where.not completed_at: nil }
  scope :incomplete, -> { where completed_at: nil }

  after_create -> { delay.sync_from_spotify! }

  def self.terminal_complete
    complete.where(<<~SQL.squish)
      (
        SELECT COUNT(*) FROM #{PlaylistSnapshotTrack.table_name}
        WHERE #{PlaylistSnapshotTrack.table_name}.playlist_snapshot_page_id = #{table_name}.id
      ) < #{table_name}.limit
    SQL
  end

  def self.with_max_offset
    order(offset: :desc).first
  end

  private

  def sync_from_spotify!
    generated_playlist_snapshot_tracks =
      tracks(limit: limit, offset: offset)
      .map
      .with_index do |track, index|
        PlaylistSnapshotTrack.new(
          spotify_track_id: track.id,
          order: index + offset
        )
      end

    transaction do
      update!(
        playlist_snapshot_tracks: generated_playlist_snapshot_tracks,
        completed_at: Time.zone.now
      )
      playlist_snapshot.playlist_snapshot_page_completed!
    end
  end
end
