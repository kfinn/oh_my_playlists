class CreateArtistAppearances < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_appearances do |t|
      t.references :artist_watch, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false
      t.string :name, null: false
      t.datetime :starting_at, null: false
      t.string :oh_my_rockness_show_id, index: true, null: false
      t.string :oh_my_rockness_band_id, index: true, null: false

      t.timestamps
    end

    add_index(
      :artist_appearances,
      [:artist_watch_id, :oh_my_rockness_show_id, :oh_my_rockness_band_id],
      name: :index_artist_appearances_on_ids,
      unique: true
    )
  end
end
