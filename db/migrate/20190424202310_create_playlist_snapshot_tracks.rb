class CreatePlaylistSnapshotTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_snapshot_tracks do |t|
      t.references :playlist_snapshot_page, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false
      t.string :spotify_track_id, null: false
      t.integer :order, null: false

      t.timestamps
    end
  end
end
