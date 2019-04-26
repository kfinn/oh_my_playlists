class AddShowSnapshotBandIdToArtistAppearances < ActiveRecord::Migration[5.2]
  def up
    ArtistAppearance.delete_all

    add_reference(
      :artist_appearances,
      :show_snapshot_band,
      foreign_key: { on_delete: :cascade, on_update: :cascade },
      null: false
    )

    remove_column :artist_appearances, :name
    remove_column :artist_appearances, :starting_at
    remove_column :artist_appearances, :oh_my_rockness_band_id
    remove_column :artist_appearances, :oh_my_rockness_show_id
    remove_column :artist_appearances, :oh_my_rockness_sync_id
  end

  def down
    ArtistAppearance.delete_all

    remove_column(:artist_appearances, :show_snapshot_band_id)

    add_column :artist_appearances, :name, :string, null: false, index: true
    add_column :artist_appearances, :starting_at, :datetime, null: false, index: true
    add_column :artist_appearances, :oh_my_rockness_band_id, :string, null: false, index: true
    add_column :artist_appearances, :oh_my_rockness_show_id, :string, null: false, index: true
    remove_column :artist_appearances, :oh_my_rockness_sync_id, :bigint, null: false, index: true
  end
end
