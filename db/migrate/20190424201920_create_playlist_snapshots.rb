class CreatePlaylistSnapshots < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_snapshots do |t|
      t.references :playlist_watch, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false

      t.timestamps
    end
  end
end
