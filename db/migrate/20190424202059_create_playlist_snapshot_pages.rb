class CreatePlaylistSnapshotPages < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_snapshot_pages do |t|
      t.references :playlist_snapshot, foreign_key: { on_delete: :cascade, on_update: :cascade }, null: false
      t.integer :offset, null: false, default: 0
      t.integer :limit, null: false, default: 100
      t.datetime :completed_at

      t.timestamps
    end

    add_index(
      :playlist_snapshot_pages,
      [:playlist_snapshot_id, :offset, :limit],
      name: :index_psps_on_ids_offset_limit,
      unique: true
    )
  end
end
