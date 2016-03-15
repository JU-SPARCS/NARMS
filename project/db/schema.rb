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

ActiveRecord::Schema.define(version: 26) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "surname",          limit: 255
    t.string   "email",            limit: 255
    t.string   "crypted_password", limit: 255
    t.string   "role",             limit: 255
    t.boolean  "active",                       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airspace_segments", force: :cascade do |t|
    t.string   "pub_id",      limit: 255
    t.boolean  "active",                  default: true
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id", limit: 4
  end

  add_index "airspace_segments", ["facility_id"], name: "index_airspace_segments_on_facility_id", using: :btree

  create_table "events_logs", force: :cascade do |t|
    t.datetime "happened_at"
    t.string   "worker_role",           limit: 255
    t.string   "worker_responsability", limit: 255
    t.string   "operational_status",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "workstation_id",        limit: 4
    t.integer  "worker_profile_id",     limit: 4
    t.string   "event_type",            limit: 255
  end

  add_index "events_logs", ["worker_profile_id"], name: "index_events_logs_on_worker_profile_id", using: :btree
  add_index "events_logs", ["workstation_id"], name: "index_events_logs_on_workstation_id", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.string   "pub_id",     limit: 255
    t.boolean  "active",                 default: true
    t.string   "name",       limit: 255
    t.string   "location",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_tables_shift_managements", force: :cascade do |t|
    t.string   "conduct_safaps_assessment",          limit: 255, default: "nobody"
    t.string   "prepare_shift_schedule",             limit: 255, default: "nobody"
    t.string   "view_atco_safaps_shift_inputs",      limit: 255, default: "nobody"
    t.string   "view_atco_safaps_shift_assessments", limit: 255, default: "nobody"
    t.string   "manage_atco_safaps_categories",      limit: 255, default: "nobody"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                            limit: 4
    t.string   "view_atco_worker_schedule",          limit: 255
    t.string   "view_atco_worker_log_event",         limit: 255
    t.string   "view_shift_schedule",                limit: 255
  end

  add_index "permissions_tables_shift_managements", ["role_id"], name: "index_permissions_tables_shift_managements_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "safaps_profiles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "safaps_requests", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "safaps_responses", force: :cascade do |t|
    t.integer  "id_evaluation",     limit: 4
    t.integer  "stress_indicator",  limit: 4
    t.integer  "fatigue_indicator", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_slots_workers", force: :cascade do |t|
    t.datetime "begin_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedules_worker_id", limit: 4
  end

  create_table "schedules_workers", force: :cascade do |t|
    t.datetime "begin_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "worker_profile_id", limit: 4
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "begin"
    t.datetime "end"
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id", limit: 4
  end

  create_table "shifts_worker_profiles", id: false, force: :cascade do |t|
    t.integer "shift_id",          limit: 4
    t.integer "worker_profile_id", limit: 4
  end

  add_index "shifts_worker_profiles", ["shift_id"], name: "index_shifts_worker_profiles_on_shift_id", using: :btree
  add_index "shifts_worker_profiles", ["worker_profile_id"], name: "index_shifts_worker_profiles_on_worker_profile_id", using: :btree

  create_table "third_parties_recipients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "third_parties_recipients_organizations", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipient_id", limit: 4
  end

  create_table "third_parties_recipients_token_holders", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "token",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id",  limit: 4
    t.integer  "tokenable_r_id",   limit: 4
    t.string   "tokenable_r_type", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "pub_id",           limit: 255
    t.string   "name",             limit: 255
    t.string   "first_name",       limit: 255
    t.string   "email",            limit: 255
    t.string   "crypted_password", limit: 255
    t.boolean  "active",                       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",          limit: 4
  end

  create_table "worker_profiles", force: :cascade do |t|
    t.string   "pub_id",        limit: 255
    t.boolean  "active",                    default: true
    t.string   "name",          limit: 255
    t.string   "first_name",    limit: 255
    t.datetime "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id",   limit: 4
    t.integer  "user_id",       limit: 4
  end

  add_index "worker_profiles", ["facility_id"], name: "index_worker_profiles_on_facility_id", using: :btree

  create_table "workstations", force: :cascade do |t|
    t.string   "pub_id",      limit: 255
    t.boolean  "active",                  default: true
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "facility_id", limit: 4
  end

  add_index "workstations", ["facility_id"], name: "index_workstations_on_facility_id", using: :btree

end
