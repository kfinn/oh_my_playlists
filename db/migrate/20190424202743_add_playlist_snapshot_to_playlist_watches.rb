class AddPlaylistSnapshotToPlaylistWatches < ActiveRecord::Migration[5.2]
  def change
    add_reference(
      :playlist_watches,
      :playlist_snapshot,
      foreign_key: { on_delete: :nullify, on_update: :cascade }
    )
  end
end
