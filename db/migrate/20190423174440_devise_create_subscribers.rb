# frozen_string_literal: true

class DeviseCreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.string :spotify_uid, null: false
      t.string :email, null: false

      t.string :spotify_credential_token, null: false
      t.string :spotify_credential_refresh_token, null: false
      t.datetime :spotify_credential_expires_at, null: false
      t.boolean :spotify_credential_expires, null: false

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :subscribers, :email, unique: true
  end
end
