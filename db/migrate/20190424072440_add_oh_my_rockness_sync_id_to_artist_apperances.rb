class AddOhMyRocknessSyncIdToArtistApperances < ActiveRecord::Migration[5.2]
  def change
    add_reference(
      :artist_appearances,
      :oh_my_rockness_sync,
      foreign_key: { on_delete: :cascade, on_update: :cascade },
      null: false
    )
  end
end
