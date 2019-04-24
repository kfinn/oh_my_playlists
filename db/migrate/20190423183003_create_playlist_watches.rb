class CreatePlaylistWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_watches do |t|
      t.references :subscriber, foreign_key: { on_delete: :cascade, on_update: :cascade }
      t.string :spotify_id, index: { unique: true }

      t.timestamps
    end
  end
end
