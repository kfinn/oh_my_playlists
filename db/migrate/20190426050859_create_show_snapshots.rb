class CreateShowSnapshots < ActiveRecord::Migration[5.2]
  def change
    create_table :show_snapshots do |t|
      t.string :oh_my_rockness_show_id, null: false, index: true
      t.datetime :starting_at, null: false, index: true

      t.timestamps
    end
  end
end
