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

ActiveRecord::Schema.define(version: 20170303151513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street",           null: false
    t.string   "number",           null: false
    t.string   "complement"
    t.string   "completed"
    t.string   "zipcode"
    t.string   "neighborhood"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "city_id",          null: false
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
    t.index ["city_id"], name: "index_addresses_on_city_id", using: :btree
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "token",      null: false
    t.datetime "expiration", null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_authentications_on_token", using: :btree
    t.index ["user_id"], name: "index_authentications_on_user_id", using: :btree
  end

  create_table "chat_messages", force: :cascade do |t|
    t.text     "content",                   null: false
    t.boolean  "visible",    default: true
    t.integer  "chat_id",                   null: false
    t.integer  "user_id",                   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["chat_id"], name: "index_chat_messages_on_chat_id", using: :btree
    t.index ["user_id"], name: "index_chat_messages_on_user_id", using: :btree
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "establishment_id",                null: false
    t.integer  "chat_messages_count", default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["establishment_id"], name: "index_chats_on_establishment_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", using: :btree
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "establishments", force: :cascade do |t|
    t.string   "name",                                             null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.text     "suggestion_message"
    t.text     "description"
    t.text     "small_description"
    t.text     "small_business_hours_description"
    t.text     "business_hours_description"
    t.string   "slug"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "phone"
    t.string   "site"
    t.string   "email"
    t.boolean  "vip",                              default: false
    t.boolean  "aprooved",                         default: true
    t.boolean  "visible",                          default: true
    t.integer  "user_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["name"], name: "index_establishments_on_name", using: :btree
    t.index ["user_id"], name: "index_establishments_on_user_id", using: :btree
  end

  create_table "establishments_tags", id: false, force: :cascade do |t|
    t.integer "establishment_id"
    t.integer "tag_id"
    t.index ["establishment_id"], name: "index_establishments_tags_on_establishment_id", using: :btree
    t.index ["tag_id"], name: "index_establishments_tags_on_tag_id", using: :btree
  end

  create_table "event_calendars", force: :cascade do |t|
    t.datetime "when"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "name",                               null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.text     "suggestion_message"
    t.text     "description"
    t.string   "slug"
    t.boolean  "vip",                default: false
    t.boolean  "aprooved",           default: true
    t.boolean  "visible",            default: true
    t.integer  "establishment_id"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["establishment_id"], name: "index_events_on_establishment_id", using: :btree
    t.index ["name"], name: "index_events_on_name", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",         null: false
    t.text     "value"
    t.string   "target_type", null: false
    t.integer  "target_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true, using: :btree
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id", using: :btree
  end

  create_table "sniffs", force: :cascade do |t|
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "label"
    t.integer  "duration"
    t.string   "sniffable_type"
    t.integer  "sniffable_id"
    t.integer  "user_id",                           null: false
    t.boolean  "active",             default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["sniffable_type", "sniffable_id"], name: "index_sniffs_on_sniffable_type_and_sniffable_id", using: :btree
    t.index ["user_id"], name: "index_sniffs_on_user_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "region"
    t.string   "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_states_on_name", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "alias",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alias"], name: "index_tags_on_alias", using: :btree
    t.index ["name"], name: "index_tags_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "cellphone"
    t.integer  "role",                   default: 0
    t.integer  "sniffs_count",           default: 0
    t.boolean  "active",                 default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
