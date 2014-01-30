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

ActiveRecord::Schema.define(version: 20140130195927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "beers", force: true do |t|
    t.string   "name"
    t.string   "brewed_by"
    t.string   "style"
    t.string   "description"
    t.float    "abv"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kegs", force: true do |t|
    t.integer  "beer_id"
    t.integer  "org_id"
    t.datetime "tapped_date"
    t.datetime "finished_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kegs", ["beer_id"], name: "index_kegs_on_beer_id", using: :btree
  add_index "kegs", ["org_id"], name: "index_kegs_on_org_id", using: :btree

  create_table "org_beer_selections", force: true do |t|
    t.integer  "org_id"
    t.integer  "beer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "org_beer_selections", ["beer_id"], name: "index_org_beer_selections_on_beer_id", using: :btree
  add_index "org_beer_selections", ["org_id"], name: "index_org_beer_selections_on_org_id", using: :btree

  create_table "orgs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taps", force: true do |t|
    t.integer  "org_id"
    t.string   "name"
    t.integer  "keg_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taps", ["keg_id"], name: "index_taps_on_keg_id", using: :btree
  add_index "taps", ["org_id"], name: "index_taps_on_org_id", using: :btree

end
