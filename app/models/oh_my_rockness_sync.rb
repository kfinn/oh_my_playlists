class OhMyRocknessSync < ApplicationRecord
  after_create -> { delay.sync! }

  def self.latest
    order(created_at: :desc).first
  end

  def sync!
    show_snapshots = Show.just_announced.in_new_york.map do |show|
      ShowSnapshot.find_or_initialize_by(oh_my_rockness_show_id: show.id).tap do |show_snapshot|
        show_snapshot.assign_attributes(starting_at: show.starts_at)
      end
    end

    transaction do
      show_snapshots.select(&:changed?).each(&:save!)
    end
  end
end
