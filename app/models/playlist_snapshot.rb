class PlaylistSnapshot < ApplicationRecord
  belongs_to :playlist_watch
  has_many :playlist_snapshot_pages, inverse_of: :playlist_snapshot, dependent: :destroy
  has_many :playlist_snapshot_tracks, through: :playlist_snapshot_pages

  after_create -> { delay.sync_from_spotify! }

  def self.latest
    order(created_at: :desc).first
  end

  def self.completed
    where(<<~SQL.squish)
      EXISTS (#{
        PlaylistSnapshotPage
          .terminal_complete
          .where("#{PlaylistSnapshotPage.table_name}.playlist_snapshot_id = #{table_name}.id")
          .to_sql
      })
    SQL
  end

  def playlist_snapshot_page_completed!
    delay.continue_sync_from_spotify!
  end

  private

  def sync_from_spotify!
    playlist_snapshot_pages.create!
  end

  def continue_sync_from_spotify!
    if playlist_snapshot_pages.terminal_complete.any?
      playlist_watch.playlist_snapshot_completed!
      return
    end

    last_page = playlist_snapshot_pages.with_max_offset
    next_page_offset = last_page ? last_page.offset + last_page.limit : 0
    playlist_snapshot_pages.create!(
      offset: next_page_offset
    )
  end
end
