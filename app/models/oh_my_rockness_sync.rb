class OhMyRocknessSync < ApplicationRecord
  after_create -> { delay.sync! }

  has_many :artist_appearances, inverse_of: :oh_my_rockness_sync

  def sync!
    Show.just_announced.in_new_york.each do |show|
      show.cached_bands.each do |cached_band|
        delay.handle_artist_appearance!(
          oh_my_rockness_show_id: show.id,
          oh_my_rockness_band_id: cached_band.id,
          name: cached_band.name,
          starting_at: show.starts_at
        )
      end
    end
  end

  def handle_artist_appearance!(oh_my_rockness_show_id:, oh_my_rockness_band_id:, name:, starting_at:)
    artist_watchces_to_update =
      ArtistWatch
      .where(name: name)
      .without_appearance_for(
        oh_my_rockness_show_id: oh_my_rockness_show_id,
        oh_my_rockness_band_id: oh_my_rockness_band_id
      )


    new_artist_appearances = artist_watchces_to_update.map do |artist_watch|
      artist_appearances.build(
        artist_watch: artist_watch,
        oh_my_rockness_show_id: oh_my_rockness_show_id,
        oh_my_rockness_band_id: oh_my_rockness_band_id,
        name: name,
        starting_at: starting_at
      )
    end

    transaction do
      new_artist_appearances.each(&:save!)
    end
  end
end
