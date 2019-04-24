class ArtistAppearance < ApplicationRecord
  belongs_to :oh_my_rockness_sync
  belongs_to :artist_watch
  has_many :song_watches, through: :artist_watch

  def show
    @show ||= Show.find(oh_my_rockness_show_id)
  end

  scope :upcoming, -> { where('starting_at > ?', Time.zone.now) }
  scope :by_date, -> { order(starting_at: :asc) }
end
