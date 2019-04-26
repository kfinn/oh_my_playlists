class CreateShowSnapshotBands < ActiveRecord::Migration[5.2]
  def change
    create_table :show_snapshot_bands do |t|
      t.references :show_snapshot, foreign_key: { on_delete: :cascade, on_update: :cascade }
      t.string :oh_my_rockness_band_id, null: false, index: true
      t.string :name, null: false, index: true

      t.timestamps
    end
  end
end
