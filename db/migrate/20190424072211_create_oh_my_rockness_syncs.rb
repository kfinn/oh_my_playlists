class CreateOhMyRocknessSyncs < ActiveRecord::Migration[5.2]
  def change
    create_table :oh_my_rockness_syncs do |t|

      t.timestamps
    end
  end
end
