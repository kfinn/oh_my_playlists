class ShowSnapshot < ApplicationRecord
  has_many :show_snapshot_bands, inverse_of: :show_snapshot, dependent: :destroy

  after_save -> { delay.sync_from_oh_my_rockness! }

  scope :by_date, -> { order starting_at: :asc }

    def show
      @show ||= Show.find(oh_my_rockness_show_id)
    end

  private

  def sync_from_oh_my_rockness!
    generated_show_snapshot_bands = show.cached_bands.map do |band|
      show_snapshot_bands
        .find_or_initialize_by(oh_my_rockness_band_id: band.id)
        .tap do |show_snapshot_band|
          show_snapshot_band.assign_attributes(
            name: band.name
          )
        end
    end

    outdated_show_snapshot_bands = show_snapshot_bands - generated_show_snapshot_bands

    transaction do
      generated_show_snapshot_bands.select(&:changed?).each(&:save!)
      outdated_show_snapshot_bands.each(&:save!)
    end
  end
end
