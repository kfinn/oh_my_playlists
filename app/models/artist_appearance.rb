class ArtistAppearance < ApplicationRecord
  belongs_to :artist_watch

  class << self
    def sync_from_oh_my_rockness!
      Show.just_announced.in_new_york.each do |show|
        show.cached_bands.each do |cached_band|
          delay.handle_artist_appearance(
            oh_my_rockness_show_id: show.id,
            oh_my_rockness_band_id: cached_band.id,
            name: cached_band.name
          )
        end
      end
    end

    def handle_artist_appearance(oh_my_rockness_show_id:, oh_my_rockness_band_id:, name:)
      artist_appearances = ArtistWatch.where(name: name).map do |artist_watch|
        artist_watch.artist_appearances.find_or_initialize_by(
          oh_my_rockness_show_id: oh_my_rockness_show_id,
          oh_my_rockness_band_id: oh_my_rockness_band_id
        ).tap { |artist_apperance| artist_apperance.name = name }
      end

      transaction do
        artist_appearances.each(&:save!)
      end
    end
  end
end
