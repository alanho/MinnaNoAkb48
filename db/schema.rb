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

ActiveRecord::Schema.define(version: 20140504163851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "occurrences", force: true do |t|
    t.integer  "vocabulary_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "occurrences", ["song_id"], name: "index_occurrences_on_song_id", using: :btree
  add_index "occurrences", ["vocabulary_id"], name: "index_occurrences_on_vocabulary_id", using: :btree

  create_table "songs", force: true do |t|
    t.string   "slug"
    t.string   "path"
    t.string   "name_jp"
    t.string   "name_romaji"
    t.string   "name_en"
    t.text     "lyric_jp"
    t.text     "lyric_romaji"
    t.text     "lyric_en"
    t.integer  "vocab_ids",    array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["slug"], name: "index_songs_on_slug", unique: true, using: :btree

  create_table "vocabularies", force: true do |t|
    t.string   "kanji"
    t.string   "furigana"
    t.string   "romaji"
    t.string   "meaning"
    t.string   "level"
    t.integer  "song_ids",   array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
