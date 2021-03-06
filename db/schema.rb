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

ActiveRecord::Schema.define(version: 2019_04_26_053343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_appearances", force: :cascade do |t|
    t.bigint "artist_watch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "show_snapshot_band_id", null: false
    t.index ["artist_watch_id"], name: "index_artist_appearances_on_artist_watch_id"
    t.index ["show_snapshot_band_id"], name: "index_artist_appearances_on_show_snapshot_band_id"
  end

  create_table "artist_watch_song_watches", force: :cascade do |t|
    t.bigint "artist_watch_id", null: false
    t.bigint "song_watch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_watch_id", "song_watch_id"], name: "index_awsws_on_ids", unique: true
    t.index ["artist_watch_id"], name: "index_artist_watch_song_watches_on_artist_watch_id"
    t.index ["song_watch_id"], name: "index_artist_watch_song_watches_on_song_watch_id"
  end

  create_table "artist_watches", force: :cascade do |t|
    t.string "spotify_artist_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spotify_artist_id"], name: "index_artist_watches_on_spotify_artist_id", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "oh_my_rockness_syncs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlist_snapshot_pages", force: :cascade do |t|
    t.bigint "playlist_snapshot_id", null: false
    t.integer "offset", default: 0, null: false
    t.integer "limit", default: 100, null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_snapshot_id", "offset", "limit"], name: "index_psps_on_ids_offset_limit", unique: true
    t.index ["playlist_snapshot_id"], name: "index_playlist_snapshot_pages_on_playlist_snapshot_id"
  end

  create_table "playlist_snapshot_tracks", force: :cascade do |t|
    t.bigint "playlist_snapshot_page_id", null: false
    t.string "spotify_track_id", null: false
    t.integer "order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_snapshot_page_id"], name: "index_playlist_snapshot_tracks_on_playlist_snapshot_page_id"
  end

  create_table "playlist_snapshots", force: :cascade do |t|
    t.bigint "playlist_watch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_watch_id"], name: "index_playlist_snapshots_on_playlist_watch_id"
  end

  create_table "playlist_watches", force: :cascade do |t|
    t.bigint "subscriber_id", null: false
    t.string "spotify_playlist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "playlist_snapshot_id"
    t.index ["playlist_snapshot_id"], name: "index_playlist_watches_on_playlist_snapshot_id"
    t.index ["spotify_playlist_id"], name: "index_playlist_watches_on_spotify_playlist_id", unique: true
    t.index ["subscriber_id"], name: "index_playlist_watches_on_subscriber_id"
  end

  create_table "show_snapshot_bands", force: :cascade do |t|
    t.bigint "show_snapshot_id"
    t.string "oh_my_rockness_band_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_show_snapshot_bands_on_name"
    t.index ["oh_my_rockness_band_id"], name: "index_show_snapshot_bands_on_oh_my_rockness_band_id"
    t.index ["show_snapshot_id"], name: "index_show_snapshot_bands_on_show_snapshot_id"
  end

  create_table "show_snapshots", force: :cascade do |t|
    t.string "oh_my_rockness_show_id", null: false
    t.datetime "starting_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oh_my_rockness_show_id"], name: "index_show_snapshots_on_oh_my_rockness_show_id"
    t.index ["starting_at"], name: "index_show_snapshots_on_starting_at"
  end

  create_table "song_watches", force: :cascade do |t|
    t.bigint "playlist_watch_id", null: false
    t.string "spotify_track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_watch_id", "spotify_track_id"], name: "index_song_watches_on_playlist_watch_id_and_spotify_track_id", unique: true
    t.index ["playlist_watch_id"], name: "index_song_watches_on_playlist_watch_id"
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
    t.index ["spotify_uid"], name: "index_subscribers_on_spotify_uid", unique: true
  end

  add_foreign_key "artist_appearances", "artist_watches", on_update: :cascade, on_delete: :cascade
  add_foreign_key "artist_appearances", "show_snapshot_bands", on_update: :cascade, on_delete: :cascade
  add_foreign_key "artist_watch_song_watches", "artist_watches", on_update: :cascade, on_delete: :cascade
  add_foreign_key "artist_watch_song_watches", "song_watches", on_update: :cascade, on_delete: :cascade
  add_foreign_key "playlist_snapshot_pages", "playlist_snapshots", on_update: :cascade, on_delete: :cascade
  add_foreign_key "playlist_snapshot_tracks", "playlist_snapshot_pages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "playlist_snapshots", "playlist_watches", on_update: :cascade, on_delete: :cascade
  add_foreign_key "playlist_watches", "playlist_snapshots", on_update: :cascade, on_delete: :nullify
  add_foreign_key "playlist_watches", "subscribers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "show_snapshot_bands", "show_snapshots", on_update: :cascade, on_delete: :cascade
  add_foreign_key "song_watches", "playlist_watches", on_update: :cascade, on_delete: :cascade
end
