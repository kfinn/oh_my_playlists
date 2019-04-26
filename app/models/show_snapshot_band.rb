class ShowSnapshotBand < ApplicationRecord
  belongs_to :show_snapshot
  has_many :artist_appearances, inverse_of: :show_snapshot_band

  after_save -> { delay.generate_artist_appearances! }

  private

  def generate_artist_appearances!
    generated_artist_appearances = ArtistWatch.where(name: name).map do |artist_watch|
      artist_appearances.find_or_initialize_by(artist_watch: artist_watch)
    end

    outdated_artist_appearances = artist_appearances - generated_artist_appearances

    transaction do
      generated_artist_appearances.select(&:changed?).each(&:save!)
      outdated_artist_appearances.each(&:destroy!)
    end
  end
end
