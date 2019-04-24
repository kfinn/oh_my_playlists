class ArtistAppearance < ApplicationRecord
  belongs_to :artist_watch

  def show
    @show ||= Show.find(oh_my_rockness_show_id)
  end

  class << self
    def sync_from_oh_my_rockness!
      Show.just_announced.in_new_york.each do |show|
        show.cached_bands.each do |cached_band|
          delay.handle_artist_appearance(
            oh_my_rockness_show_id: show.id,
            oh_my_rockness_band_id: cached_band.id,
            name: cached_band.name,
            starting_at: show.starts_at
          )
        end
      end
    end

    def handle_artist_appearance(oh_my_rockness_show_id:, oh_my_rockness_band_id:, name:, starting_at:)
      artist_appearances = ArtistWatch.where(name: name).map do |artist_watch|
        artist_watch.artist_appearances.find_or_initialize_by(
          oh_my_rockness_show_id: oh_my_rockness_show_id,
          oh_my_rockness_band_id: oh_my_rockness_band_id
        ).tap do |artist_apperance|
          artist_apperance.assign_attributes(
            name: name,
            starting_at: starting_at
          )
        end
      end

      transaction do
        artist_appearances.each(&:save!)
      end
    end
  end

  scope :upcoming, -> { where('starting_at > ?', Time.zone.now) }
  scope :by_date, -> { order(starting_at: :asc)}
end
