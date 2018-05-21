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

ActiveRecord::Schema.define(version: 20180521115042) do

  create_table "authorities", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.string   "surname"
    t.string   "position"
    t.text     "about"
    t.date     "dob"
    t.string   "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "contacts", force: :cascade do |t|
    t.string   "country"
    t.string   "city"
    t.string   "postcode"
    t.string   "street"
    t.integer  "phone",        limit: 8
    t.string   "email"
    t.integer  "authority_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "contacts", ["authority_id"], name: "index_contacts_on_authority_id"

  create_table "contacts_teams", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "contact_id"
  end

  add_index "contacts_teams", ["contact_id", "team_id"], name: "index_contacts_teams_on_contact_id_and_team_id", unique: true
  add_index "contacts_teams", ["contact_id"], name: "index_contacts_teams_on_contact_id"
  add_index "contacts_teams", ["team_id"], name: "index_contacts_teams_on_team_id"

  create_table "editors", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "papers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.date     "published"
    t.integer  "authority_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "papers", ["authority_id"], name: "index_papers_on_authority_id"

  create_table "papers_teams", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "paper_id"
  end

  add_index "papers_teams", ["paper_id", "team_id"], name: "index_papers_teams_on_paper_id_and_team_id", unique: true
  add_index "papers_teams", ["paper_id"], name: "index_papers_teams_on_paper_id"
  add_index "papers_teams", ["team_id"], name: "index_papers_teams_on_team_id"

  create_table "photos", force: :cascade do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.text     "description"
    t.integer  "authority_id"
    t.integer  "paper_id"
    t.integer  "project_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "photos", ["authority_id"], name: "index_photos_on_authority_id"
  add_index "photos", ["paper_id"], name: "index_photos_on_paper_id"
  add_index "photos", ["project_id"], name: "index_photos_on_project_id"

  create_table "photos_teams", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "photo_id"
  end

  add_index "photos_teams", ["photo_id", "team_id"], name: "index_photos_teams_on_photo_id_and_team_id", unique: true
  add_index "photos_teams", ["photo_id"], name: "index_photos_teams_on_photo_id"
  add_index "photos_teams", ["team_id"], name: "index_photos_teams_on_team_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "about"
    t.date     "started"
    t.date     "finished"
    t.string   "url"
    t.integer  "authority_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "current"
  end

  add_index "projects", ["authority_id"], name: "index_projects_on_authority_id"

  create_table "projects_teams", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "project_id"
  end

  add_index "projects_teams", ["project_id", "team_id"], name: "index_projects_teams_on_project_id_and_team_id", unique: true
  add_index "projects_teams", ["project_id"], name: "index_projects_teams_on_project_id"
  add_index "projects_teams", ["team_id"], name: "index_projects_teams_on_team_id"

  create_table "teams", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.string   "surname"
    t.string   "position"
    t.text     "about"
    t.date     "dob"
    t.string   "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
