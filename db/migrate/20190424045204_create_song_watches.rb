class CreateSongWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :song_watches do |t|
      t.references :playlist_watch, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false
      t.string :spotify_track_id, null: false

      t.timestamps
    end

    add_index(
      :song_watches,
      [:playlist_watch_id, :spotify_track_id],
      unique: true
    )
  end
end
