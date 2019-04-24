class CreatePlaylistWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_watches do |t|
      t.references :subscriber, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false
      t.string :spotify_playlist_id, index: { unique: true }, null: false

      t.timestamps
    end
  end
end
