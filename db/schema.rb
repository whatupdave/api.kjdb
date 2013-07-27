# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130727044246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: true do |t|
    t.integer  "artist_id",    null: false
    t.string   "slug",         null: false
    t.string   "name",         null: false
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["slug"], name: "index_albums_on_slug", unique: true, using: :btree

  create_table "artists", force: true do |t|
    t.string   "slug",       null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["slug"], name: "index_artists_on_slug", unique: true, using: :btree

  create_table "songbook_entries", force: true do |t|
    t.integer  "songbook_id", null: false
    t.string   "artist",      null: false
    t.string   "title",       null: false
    t.datetime "created_at",  null: false
    t.integer  "track_id"
  end

  add_index "songbook_entries", ["artist", "title"], name: "index_songbook_entries_on_artist_and_title", unique: true, using: :btree

  create_table "songbooks", force: true do |t|
    t.string   "slug",       null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songbooks", ["slug"], name: "index_songbooks_on_slug", unique: true, using: :btree

  create_table "tracks", force: true do |t|
    t.integer  "album_id",   null: false
    t.string   "slug",       null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["slug"], name: "index_tracks_on_slug", unique: true, using: :btree

end
