# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_23_183003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "playlist_watches", force: :cascade do |t|
    t.bigint "subscriber_id"
    t.string "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_id"], name: "index_playlist_watches_on_spotify_id", unique: true
    t.index ["subscriber_id"], name: "index_playlist_watches_on_subscriber_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "spotify_uid", null: false
    t.string "email", null: false
    t.string "spotify_credential_token", null: false
    t.string "spotify_credential_refresh_token", null: false
    t.datetime "spotify_credential_expires_at", null: false
    t.boolean "spotify_credential_expires", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subscribers_on_email", unique: true
  end

  add_foreign_key "playlist_watches", "subscribers", on_update: :cascade, on_delete: :cascade
end
