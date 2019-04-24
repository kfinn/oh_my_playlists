class CreateArtistWatchSongWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_watch_song_watches do |t|
      t.references :artist_watch, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false
      t.references :song_watch, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false

      t.timestamps
    end

    add_index(
      :artist_watch_song_watches,
      [:artist_watch_id, :song_watch_id],
      name: :index_awsws_on_ids,
      unique: true
    )
  end
end
