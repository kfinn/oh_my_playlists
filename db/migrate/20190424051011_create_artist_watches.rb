class CreateArtistWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_watches do |t|
      t.string :spotify_artist_id, index: { unique: true }, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
