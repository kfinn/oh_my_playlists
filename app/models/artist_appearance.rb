class ArtistAppearance < ApplicationRecord
  belongs_to :artist_watch
  has_many :song_watches, through: :artist_watch
  belongs_to :show_snapshot_band
  has_one :show_snapshot, through: :show_snapshot_band
  delegate :show, to: :show_snapshot
  delegate :name, to: :show_snapshot_band

  scope :upcoming, -> { where('starting_at > ?', Time.zone.now) }
  scope :by_date, -> { joins(:show_snapshot).merge(ShowSnapshot.by_date) }
end
