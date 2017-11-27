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

ActiveRecord::Schema.define(version: 20171127170428) do

  create_table "actions", primary_key: "aid", force: :cascade do |t|
    t.string "type",       limit: 32,         default: "",  null: false
    t.string "callback",   limit: 255,        default: "",  null: false
    t.binary "parameters", limit: 4294967295,               null: false
    t.string "label",      limit: 255,        default: "0", null: false
  end

  create_table "advanced_help_index", primary_key: "sid", force: :cascade do |t|
    t.string "module",   limit: 255, default: "", null: false
    t.string "topic",    limit: 255, default: "", null: false
    t.string "language", limit: 12,  default: "", null: false
  end

  add_index "advanced_help_index", ["language"], name: "language", using: :btree

  create_table "authmap", primary_key: "aid", force: :cascade do |t|
    t.integer "uid",      limit: 4,   default: 0,  null: false
    t.string  "authname", limit: 128, default: "", null: false
    t.string  "module",   limit: 128, default: "", null: false
  end

  add_index "authmap", ["authname"], name: "authname", unique: true, using: :btree
  add_index "authmap", ["uid", "module"], name: "uid_module", using: :btree

  create_table "backup_migrate_destinations", primary_key: "destination_id", force: :cascade do |t|
    t.string "name",     limit: 255,   null: false
    t.string "type",     limit: 32,    null: false
    t.text   "location", limit: 65535, null: false
    t.text   "settings", limit: 65535, null: false
  end

  create_table "backup_migrate_profiles", primary_key: "profile_id", force: :cascade do |t|
    t.string  "name",             limit: 255,               null: false
    t.string  "filename",         limit: 255,               null: false
    t.integer "append_timestamp", limit: 1,     default: 0, null: false
    t.string  "timestamp_format", limit: 14,                null: false
    t.text    "filters",          limit: 65535,             null: false
  end

  create_table "backup_migrate_schedules", primary_key: "schedule_id", force: :cascade do |t|
    t.string  "name",           limit: 255,                null: false
    t.string  "source_id",      limit: 255, default: "db", null: false
    t.string  "destination_id", limit: 255, default: "0",  null: false
    t.string  "profile_id",     limit: 255, default: "0",  null: false
    t.integer "keep",           limit: 4,   default: 0,    null: false
    t.integer "period",         limit: 4,   default: 0,    null: false
    t.integer "enabled",        limit: 1,   default: 0,    null: false
    t.integer "cron",           limit: 1,   default: 0,    null: false
  end

  create_table "batch", primary_key: "bid", force: :cascade do |t|
    t.string  "token",     limit: 64,         null: false
    t.integer "timestamp", limit: 4,          null: false
    t.binary  "batch",     limit: 4294967295
  end

  add_index "batch", ["token"], name: "token", using: :btree

  create_table "block", primary_key: "bid", force: :cascade do |t|
    t.string  "module",     limit: 64,         default: "",  null: false
    t.string  "delta",      limit: 32,         default: "0", null: false
    t.string  "theme",      limit: 64,         default: "",  null: false
    t.integer "status",     limit: 1,          default: 0,   null: false
    t.integer "weight",     limit: 4,          default: 0,   null: false
    t.string  "region",     limit: 64,         default: "",  null: false
    t.integer "custom",     limit: 1,          default: 0,   null: false
    t.integer "visibility", limit: 1,          default: 0,   null: false
    t.text    "pages",      limit: 65535,                    null: false
    t.string  "title",      limit: 255,        default: "",  null: false
    t.integer "cache",      limit: 1,          default: 1,   null: false
    t.text    "css",        limit: 65535
    t.text    "js",         limit: 65535
    t.text    "noscript",   limit: 4294967295
  end

  add_index "block", ["theme", "module", "delta"], name: "tmd", unique: true, using: :btree
  add_index "block", ["theme", "status", "region", "weight", "module"], name: "list", using: :btree

  create_table "block_current_search", primary_key: "delta", force: :cascade do |t|
    t.string "searcher", limit: 128, null: false
  end

  add_index "block_current_search", ["searcher"], name: "searcher", using: :btree

  create_table "block_custom", primary_key: "bid", force: :cascade do |t|
    t.text   "body",   limit: 4294967295
    t.string "info",   limit: 128,        default: "", null: false
    t.string "format", limit: 255
  end

  add_index "block_custom", ["info"], name: "info", unique: true, using: :btree

  create_table "block_node_type", id: false, force: :cascade do |t|
    t.string "module", limit: 64, null: false
    t.string "delta",  limit: 32, null: false
    t.string "type",   limit: 32, null: false
  end

  add_index "block_node_type", ["type"], name: "type", using: :btree

  create_table "block_role", id: false, force: :cascade do |t|
    t.string  "module", limit: 64, null: false
    t.string  "delta",  limit: 32, null: false
    t.integer "rid",    limit: 4,  null: false
  end

  add_index "block_role", ["rid"], name: "rid", using: :btree

  create_table "blocked_ips", primary_key: "iid", force: :cascade do |t|
    t.string "ip", limit: 40, default: "", null: false
  end

  add_index "blocked_ips", ["ip"], name: "blocked_ip", using: :btree

  create_table "cache", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache", ["expire"], name: "expire", using: :btree

  create_table "cache_admin_menu", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_admin_menu", ["expire"], name: "expire", using: :btree

  create_table "cache_block", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_block", ["expire"], name: "expire", using: :btree

  create_table "cache_bootstrap", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_bootstrap", ["expire"], name: "expire", using: :btree

  create_table "cache_coder", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_coder", ["expire"], name: "expire", using: :btree

  create_table "cache_field", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_field", ["expire"], name: "expire", using: :btree

  create_table "cache_filter", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_filter", ["expire"], name: "expire", using: :btree

  create_table "cache_form", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_form", ["expire"], name: "expire", using: :btree

  create_table "cache_image", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_image", ["expire"], name: "expire", using: :btree

  create_table "cache_libraries", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_libraries", ["expire"], name: "expire", using: :btree

  create_table "cache_menu", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_menu", ["expire"], name: "expire", using: :btree

  create_table "cache_page", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_page", ["expire"], name: "expire", using: :btree

  create_table "cache_path", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_path", ["expire"], name: "expire", using: :btree

  create_table "cache_rules", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_rules", ["expire"], name: "expire", using: :btree

  create_table "cache_token", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_token", ["expire"], name: "expire", using: :btree

  create_table "cache_update", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_update", ["expire"], name: "expire", using: :btree

  create_table "cache_views", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 0, null: false
  end

  add_index "cache_views", ["expire"], name: "expire", using: :btree

  create_table "cache_views_data", primary_key: "cid", force: :cascade do |t|
    t.binary  "data",       limit: 4294967295
    t.integer "expire",     limit: 4,          default: 0, null: false
    t.integer "created",    limit: 4,          default: 0, null: false
    t.integer "serialized", limit: 2,          default: 1, null: false
  end

  add_index "cache_views_data", ["expire"], name: "expire", using: :btree

  create_table "civicrm_acl", force: :cascade do |t|
    t.string  "name",         limit: 64
    t.integer "deny",         limit: 1,  default: 0, null: false
    t.string  "entity_table", limit: 64,             null: false
    t.integer "entity_id",    limit: 4
    t.string  "operation",    limit: 8,              null: false
    t.string  "object_table", limit: 64
    t.integer "object_id",    limit: 4
    t.string  "acl_table",    limit: 64
    t.integer "acl_id",       limit: 4
    t.integer "is_active",    limit: 1
  end

  add_index "civicrm_acl", ["acl_id"], name: "index_acl_id", using: :btree

  create_table "civicrm_acl_cache", force: :cascade do |t|
    t.integer  "contact_id",    limit: 4
    t.integer  "acl_id",        limit: 4, null: false
    t.datetime "modified_date"
  end

  add_index "civicrm_acl_cache", ["acl_id"], name: "index_acl_id", using: :btree
  add_index "civicrm_acl_cache", ["contact_id"], name: "FK_civicrm_acl_cache_contact_id", using: :btree

  create_table "civicrm_acl_contact_cache", force: :cascade do |t|
    t.integer "user_id",    limit: 4
    t.integer "contact_id", limit: 4, null: false
    t.string  "operation",  limit: 8, null: false
  end

  add_index "civicrm_acl_contact_cache", ["contact_id"], name: "FK_civicrm_acl_contact_cache_contact_id", using: :btree
  add_index "civicrm_acl_contact_cache", ["user_id", "contact_id", "operation"], name: "UI_user_contact_operation", unique: true, using: :btree

  create_table "civicrm_acl_entity_role", force: :cascade do |t|
    t.integer "acl_role_id",  limit: 4,  null: false
    t.string  "entity_table", limit: 64, null: false
    t.integer "entity_id",    limit: 4,  null: false
    t.integer "is_active",    limit: 1
  end

  add_index "civicrm_acl_entity_role", ["acl_role_id"], name: "index_role", using: :btree
  add_index "civicrm_acl_entity_role", ["entity_table", "entity_id"], name: "index_entity", using: :btree

  create_table "civicrm_action_log", force: :cascade do |t|
    t.integer  "contact_id",         limit: 4
    t.integer  "entity_id",          limit: 4,                 null: false
    t.string   "entity_table",       limit: 255
    t.integer  "action_schedule_id", limit: 4,                 null: false
    t.datetime "action_date_time"
    t.integer  "is_error",           limit: 1,     default: 0
    t.text     "message",            limit: 65535
    t.integer  "repetition_number",  limit: 4
    t.date     "reference_date"
  end

  add_index "civicrm_action_log", ["action_schedule_id"], name: "FK_civicrm_action_log_action_schedule_id", using: :btree
  add_index "civicrm_action_log", ["contact_id"], name: "FK_civicrm_action_log_contact_id", using: :btree

  create_table "civicrm_action_mapping", force: :cascade do |t|
    t.string "entity",              limit: 64
    t.string "entity_value",        limit: 64
    t.string "entity_value_label",  limit: 64
    t.string "entity_status",       limit: 64
    t.string "entity_status_label", limit: 64
    t.string "entity_date_start",   limit: 64
    t.string "entity_date_end",     limit: 64
    t.string "entity_recipient",    limit: 64
  end

  create_table "civicrm_action_schedule", force: :cascade do |t|
    t.string  "name",                          limit: 64
    t.string  "title",                         limit: 64
    t.string  "recipient",                     limit: 64
    t.integer "limit_to",                      limit: 1
    t.string  "entity_value",                  limit: 255
    t.string  "entity_status",                 limit: 64
    t.integer "start_action_offset",           limit: 4
    t.string  "start_action_unit",             limit: 8
    t.string  "start_action_condition",        limit: 64
    t.string  "start_action_date",             limit: 64
    t.integer "is_repeat",                     limit: 1,          default: 0
    t.string  "repetition_frequency_unit",     limit: 8
    t.integer "repetition_frequency_interval", limit: 4
    t.string  "end_frequency_unit",            limit: 8
    t.integer "end_frequency_interval",        limit: 4
    t.string  "end_action",                    limit: 32
    t.string  "end_date",                      limit: 64
    t.integer "is_active",                     limit: 1,          default: 1
    t.string  "recipient_manual",              limit: 128
    t.string  "recipient_listing",             limit: 128
    t.text    "body_text",                     limit: 4294967295
    t.text    "body_html",                     limit: 4294967295
    t.text    "sms_body_text",                 limit: 4294967295
    t.string  "subject",                       limit: 128
    t.integer "record_activity",               limit: 1
    t.string  "mapping_id",                    limit: 64
    t.integer "group_id",                      limit: 4
    t.integer "msg_template_id",               limit: 4
    t.integer "sms_template_id",               limit: 4
    t.date    "absolute_date"
    t.string  "from_name",                     limit: 255
    t.string  "from_email",                    limit: 255
    t.string  "mode",                          limit: 128,        default: "Email"
    t.integer "sms_provider_id",               limit: 4
    t.string  "used_for",                      limit: 64
    t.string  "filter_contact_language",       limit: 128
    t.string  "communication_language",        limit: 8
  end

  add_index "civicrm_action_schedule", ["group_id"], name: "FK_civicrm_action_schedule_group_id", using: :btree
  add_index "civicrm_action_schedule", ["mapping_id"], name: "FK_civicrm_action_schedule_mapping_id", using: :btree
  add_index "civicrm_action_schedule", ["msg_template_id"], name: "FK_civicrm_action_schedule_msg_template_id", using: :btree
  add_index "civicrm_action_schedule", ["sms_provider_id"], name: "FK_civicrm_action_schedule_sms_provider_id", using: :btree
  add_index "civicrm_action_schedule", ["sms_template_id"], name: "FK_civicrm_action_schedule_sms_template_id", using: :btree

  create_table "civicrm_activity", force: :cascade do |t|
    t.integer  "source_record_id",    limit: 4
    t.integer  "activity_type_id",    limit: 4,          default: 1, null: false
    t.string   "subject",             limit: 255
    t.datetime "activity_date_time"
    t.integer  "duration",            limit: 4
    t.string   "location",            limit: 255
    t.integer  "phone_id",            limit: 4
    t.string   "phone_number",        limit: 64
    t.text     "details",             limit: 4294967295
    t.integer  "status_id",           limit: 4
    t.integer  "priority_id",         limit: 4
    t.integer  "parent_id",           limit: 4
    t.integer  "is_test",             limit: 1,          default: 0
    t.integer  "medium_id",           limit: 4
    t.integer  "is_auto",             limit: 1,          default: 0
    t.integer  "relationship_id",     limit: 4
    t.integer  "is_current_revision", limit: 1,          default: 1
    t.integer  "original_id",         limit: 4
    t.string   "result",              limit: 255
    t.integer  "is_deleted",          limit: 1,          default: 0
    t.integer  "campaign_id",         limit: 4
    t.integer  "engagement_level",    limit: 4
    t.integer  "weight",              limit: 4
    t.integer  "is_star",             limit: 1,          default: 0
  end

  add_index "civicrm_activity", ["activity_date_time"], name: "index_activity_date_time", using: :btree
  add_index "civicrm_activity", ["activity_type_id"], name: "UI_activity_type_id", using: :btree
  add_index "civicrm_activity", ["campaign_id"], name: "FK_civicrm_activity_campaign_id", using: :btree
  add_index "civicrm_activity", ["is_current_revision"], name: "index_is_current_revision", using: :btree
  add_index "civicrm_activity", ["is_deleted"], name: "index_is_deleted", using: :btree
  add_index "civicrm_activity", ["medium_id"], name: "index_medium_id", using: :btree
  add_index "civicrm_activity", ["original_id"], name: "FK_civicrm_activity_original_id", using: :btree
  add_index "civicrm_activity", ["parent_id"], name: "FK_civicrm_activity_parent_id", using: :btree
  add_index "civicrm_activity", ["phone_id"], name: "FK_civicrm_activity_phone_id", using: :btree
  add_index "civicrm_activity", ["relationship_id"], name: "FK_civicrm_activity_relationship_id", using: :btree
  add_index "civicrm_activity", ["source_record_id"], name: "UI_source_record_id", using: :btree
  add_index "civicrm_activity", ["status_id"], name: "index_status_id", using: :btree

  create_table "civicrm_activity_contact", force: :cascade do |t|
    t.integer "activity_id",    limit: 4, null: false
    t.integer "contact_id",     limit: 4, null: false
    t.integer "record_type_id", limit: 4
  end

  add_index "civicrm_activity_contact", ["activity_id", "record_type_id"], name: "index_record_type", using: :btree
  add_index "civicrm_activity_contact", ["contact_id", "activity_id", "record_type_id"], name: "UI_activity_contact", unique: true, using: :btree

  create_table "civicrm_address", force: :cascade do |t|
    t.integer "contact_id",                    limit: 4
    t.integer "location_type_id",              limit: 4
    t.integer "is_primary",                    limit: 1,   default: 0
    t.integer "is_billing",                    limit: 1,   default: 0
    t.string  "street_address",                limit: 96
    t.integer "street_number",                 limit: 4
    t.string  "street_number_suffix",          limit: 8
    t.string  "street_number_predirectional",  limit: 8
    t.string  "street_name",                   limit: 64
    t.string  "street_type",                   limit: 8
    t.string  "street_number_postdirectional", limit: 8
    t.string  "street_unit",                   limit: 16
    t.string  "supplemental_address_1",        limit: 96
    t.string  "supplemental_address_2",        limit: 96
    t.string  "supplemental_address_3",        limit: 96
    t.string  "city",                          limit: 64
    t.integer "county_id",                     limit: 4
    t.integer "state_province_id",             limit: 4
    t.string  "postal_code_suffix",            limit: 12
    t.string  "postal_code",                   limit: 64
    t.string  "usps_adc",                      limit: 32
    t.integer "country_id",                    limit: 4
    t.float   "geo_code_1",                    limit: 53
    t.float   "geo_code_2",                    limit: 53
    t.integer "manual_geo_code",               limit: 1,   default: 0
    t.string  "timezone",                      limit: 8
    t.string  "name",                          limit: 255
    t.integer "master_id",                     limit: 4
  end

  add_index "civicrm_address", ["city"], name: "index_city", using: :btree
  add_index "civicrm_address", ["contact_id"], name: "FK_civicrm_address_contact_id", using: :btree
  add_index "civicrm_address", ["country_id"], name: "FK_civicrm_address_country_id", using: :btree
  add_index "civicrm_address", ["county_id"], name: "FK_civicrm_address_county_id", using: :btree
  add_index "civicrm_address", ["is_billing"], name: "index_is_billing", using: :btree
  add_index "civicrm_address", ["is_primary"], name: "index_is_primary", using: :btree
  add_index "civicrm_address", ["location_type_id"], name: "index_location_type", using: :btree
  add_index "civicrm_address", ["master_id"], name: "FK_civicrm_address_master_id", using: :btree
  add_index "civicrm_address", ["state_province_id"], name: "FK_civicrm_address_state_province_id", using: :btree
  add_index "civicrm_address", ["street_address"], name: "dedupe_index_street_address_5", length: {"street_address"=>5}, using: :btree
  add_index "civicrm_address", ["street_name"], name: "index_street_name", using: :btree

  create_table "civicrm_address_format", force: :cascade do |t|
    t.text "format", limit: 65535
  end

  create_table "civicrm_batch", force: :cascade do |t|
    t.string   "name",                  limit: 64
    t.string   "title",                 limit: 255
    t.text     "description",           limit: 65535
    t.integer  "created_id",            limit: 4
    t.datetime "created_date"
    t.integer  "modified_id",           limit: 4
    t.datetime "modified_date"
    t.integer  "saved_search_id",       limit: 4
    t.integer  "status_id",             limit: 4,                                   null: false
    t.integer  "type_id",               limit: 4
    t.integer  "mode_id",               limit: 4
    t.decimal  "total",                                    precision: 20, scale: 2
    t.integer  "item_count",            limit: 4
    t.integer  "payment_instrument_id", limit: 4
    t.datetime "exported_date"
    t.text     "data",                  limit: 4294967295
  end

  add_index "civicrm_batch", ["created_id"], name: "FK_civicrm_batch_created_id", using: :btree
  add_index "civicrm_batch", ["modified_id"], name: "FK_civicrm_batch_modified_id", using: :btree
  add_index "civicrm_batch", ["name"], name: "UI_name", unique: true, using: :btree
  add_index "civicrm_batch", ["saved_search_id"], name: "FK_civicrm_batch_saved_search_id", using: :btree

  create_table "civicrm_cache", force: :cascade do |t|
    t.string   "group_name",   limit: 32,         null: false
    t.string   "path",         limit: 255
    t.text     "data",         limit: 4294967295
    t.integer  "component_id", limit: 4
    t.datetime "created_date"
    t.datetime "expired_date"
  end

  add_index "civicrm_cache", ["component_id"], name: "FK_civicrm_cache_component_id", using: :btree
  add_index "civicrm_cache", ["group_name", "path", "created_date"], name: "UI_group_path_date", unique: true, using: :btree

  create_table "civicrm_campaign", force: :cascade do |t|
    t.string   "name",                limit: 255,                                        null: false
    t.string   "title",               limit: 255
    t.text     "description",         limit: 65535
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "campaign_type_id",    limit: 4
    t.integer  "status_id",           limit: 4
    t.string   "external_identifier", limit: 32
    t.integer  "parent_id",           limit: 4
    t.integer  "is_active",           limit: 1,                              default: 1
    t.integer  "created_id",          limit: 4
    t.datetime "created_date"
    t.integer  "last_modified_id",    limit: 4
    t.datetime "last_modified_date"
    t.text     "goal_general",        limit: 65535
    t.decimal  "goal_revenue",                      precision: 20, scale: 2
  end

  add_index "civicrm_campaign", ["campaign_type_id"], name: "UI_campaign_type_id", using: :btree
  add_index "civicrm_campaign", ["created_id"], name: "FK_civicrm_campaign_created_id", using: :btree
  add_index "civicrm_campaign", ["external_identifier"], name: "UI_external_identifier", unique: true, using: :btree
  add_index "civicrm_campaign", ["last_modified_id"], name: "FK_civicrm_campaign_last_modified_id", using: :btree
  add_index "civicrm_campaign", ["parent_id"], name: "FK_civicrm_campaign_parent_id", using: :btree
  add_index "civicrm_campaign", ["status_id"], name: "UI_campaign_status_id", using: :btree

  create_table "civicrm_campaign_group", force: :cascade do |t|
    t.integer "campaign_id",  limit: 4,  null: false
    t.string  "group_type",   limit: 8
    t.string  "entity_table", limit: 64
    t.integer "entity_id",    limit: 4
  end

  add_index "civicrm_campaign_group", ["campaign_id"], name: "FK_civicrm_campaign_group_campaign_id", using: :btree

  create_table "civicrm_case", force: :cascade do |t|
    t.integer "case_type_id", limit: 4,                 null: false
    t.string  "subject",      limit: 128
    t.date    "start_date"
    t.date    "end_date"
    t.text    "details",      limit: 65535
    t.integer "status_id",    limit: 4,                 null: false
    t.integer "is_deleted",   limit: 1,     default: 0
  end

  add_index "civicrm_case", ["case_type_id"], name: "index_case_type_id", using: :btree
  add_index "civicrm_case", ["is_deleted"], name: "index_is_deleted", using: :btree

  create_table "civicrm_case_activity", force: :cascade do |t|
    t.integer "case_id",     limit: 4, null: false
    t.integer "activity_id", limit: 4, null: false
  end

  add_index "civicrm_case_activity", ["activity_id"], name: "FK_civicrm_case_activity_activity_id", using: :btree
  add_index "civicrm_case_activity", ["case_id", "activity_id"], name: "UI_case_activity_id", using: :btree

  create_table "civicrm_case_contact", force: :cascade do |t|
    t.integer "case_id",    limit: 4, null: false
    t.integer "contact_id", limit: 4, null: false
  end

  add_index "civicrm_case_contact", ["case_id", "contact_id"], name: "UI_case_contact_id", unique: true, using: :btree
  add_index "civicrm_case_contact", ["contact_id"], name: "FK_civicrm_case_contact_contact_id", using: :btree

  create_table "civicrm_case_type", force: :cascade do |t|
    t.string  "name",        limit: 64,                null: false
    t.string  "title",       limit: 64,                null: false
    t.string  "description", limit: 255
    t.integer "is_active",   limit: 1
    t.integer "is_reserved", limit: 1
    t.integer "weight",      limit: 4,     default: 1, null: false
    t.binary  "definition",  limit: 65535
  end

  add_index "civicrm_case_type", ["name"], name: "case_type_name", unique: true, using: :btree

  create_table "civicrm_component", force: :cascade do |t|
    t.string "name",      limit: 64,  null: false
    t.string "namespace", limit: 128
  end

  create_table "civicrm_contact", force: :cascade do |t|
    t.string   "contact_type",                   limit: 64
    t.string   "contact_sub_type",               limit: 255
    t.integer  "do_not_email",                   limit: 1,     default: 0
    t.integer  "do_not_phone",                   limit: 1,     default: 0
    t.integer  "do_not_mail",                    limit: 1,     default: 0
    t.integer  "do_not_sms",                     limit: 1,     default: 0
    t.integer  "do_not_trade",                   limit: 1,     default: 0
    t.integer  "is_opt_out",                     limit: 1,     default: 0,      null: false
    t.string   "legal_identifier",               limit: 32
    t.string   "external_identifier",            limit: 64
    t.string   "sort_name",                      limit: 128
    t.string   "display_name",                   limit: 128
    t.string   "nick_name",                      limit: 128
    t.string   "legal_name",                     limit: 128
    t.text     "image_URL",                      limit: 65535
    t.string   "preferred_communication_method", limit: 255
    t.string   "preferred_language",             limit: 5
    t.string   "preferred_mail_format",          limit: 8,     default: "Both"
    t.string   "hash_key",                       limit: 32
    t.string   "api_key",                        limit: 32
    t.string   "source",                         limit: 255
    t.string   "first_name",                     limit: 64
    t.string   "middle_name",                    limit: 64
    t.string   "last_name",                      limit: 64
    t.integer  "prefix_id",                      limit: 4
    t.integer  "suffix_id",                      limit: 4
    t.string   "formal_title",                   limit: 64
    t.integer  "communication_style_id",         limit: 4
    t.integer  "email_greeting_id",              limit: 4
    t.string   "email_greeting_custom",          limit: 128
    t.string   "email_greeting_display",         limit: 255
    t.integer  "postal_greeting_id",             limit: 4
    t.string   "postal_greeting_custom",         limit: 128
    t.string   "postal_greeting_display",        limit: 255
    t.integer  "addressee_id",                   limit: 4
    t.string   "addressee_custom",               limit: 128
    t.string   "addressee_display",              limit: 255
    t.string   "job_title",                      limit: 255
    t.integer  "gender_id",                      limit: 4
    t.date     "birth_date"
    t.integer  "is_deceased",                    limit: 1,     default: 0
    t.date     "deceased_date"
    t.string   "household_name",                 limit: 128
    t.integer  "primary_contact_id",             limit: 4
    t.string   "organization_name",              limit: 128
    t.string   "sic_code",                       limit: 8
    t.string   "user_unique_id",                 limit: 255
    t.integer  "employer_id",                    limit: 4
    t.integer  "is_deleted",                     limit: 1,     default: 0,      null: false
    t.datetime "created_date"
    t.datetime "modified_date"
  end

  add_index "civicrm_contact", ["api_key"], name: "index_api_key", using: :btree
  add_index "civicrm_contact", ["birth_date"], name: "dedupe_index_birth_date", using: :btree
  add_index "civicrm_contact", ["communication_style_id"], name: "index_communication_style_id", using: :btree
  add_index "civicrm_contact", ["contact_sub_type"], name: "index_contact_sub_type", using: :btree
  add_index "civicrm_contact", ["contact_type"], name: "index_contact_type", using: :btree
  add_index "civicrm_contact", ["employer_id"], name: "FK_civicrm_contact_employer_id", using: :btree
  add_index "civicrm_contact", ["external_identifier"], name: "UI_external_identifier", unique: true, using: :btree
  add_index "civicrm_contact", ["first_name"], name: "dedupe_index_first_name_4", length: {"first_name"=>4}, using: :btree
  add_index "civicrm_contact", ["first_name"], name: "index_first_name", using: :btree
  add_index "civicrm_contact", ["gender_id"], name: "dedupe_index_gender_id", using: :btree
  add_index "civicrm_contact", ["hash_key"], name: "index_hash", using: :btree
  add_index "civicrm_contact", ["household_name"], name: "index_household_name", using: :btree
  add_index "civicrm_contact", ["image_URL"], name: "index_image_URL_128", length: {"image_URL"=>128}, using: :btree
  add_index "civicrm_contact", ["is_deleted", "sort_name", "id"], name: "index_is_deleted_sort_name", using: :btree
  add_index "civicrm_contact", ["last_name"], name: "index_last_name", using: :btree
  add_index "civicrm_contact", ["organization_name"], name: "index_organization_name", using: :btree
  add_index "civicrm_contact", ["preferred_communication_method"], name: "index_preferred_communication_method", using: :btree
  add_index "civicrm_contact", ["prefix_id"], name: "UI_prefix", using: :btree
  add_index "civicrm_contact", ["primary_contact_id"], name: "FK_civicrm_contact_primary_contact_id", using: :btree
  add_index "civicrm_contact", ["sort_name"], name: "index_sort_name", using: :btree
  add_index "civicrm_contact", ["suffix_id"], name: "UI_suffix", using: :btree

  create_table "civicrm_contact_groups_view", id: false, force: :cascade do |t|
    t.text    "group_id",     limit: 65535
    t.integer "contact_id",   limit: 4,     default: 0
    t.text    "name",         limit: 65535
    t.text    "title",        limit: 65535
    t.text    "children",     limit: 65535
    t.text    "parents",      limit: 65535
    t.string  "display_name", limit: 128
  end

  create_table "civicrm_contact_id_view", id: false, force: :cascade do |t|
    t.integer "id",           limit: 4,   default: 0, null: false
    t.string  "last_name",    limit: 64
    t.string  "first_name",   limit: 64
    t.string  "display_name", limit: 128
  end

  create_table "civicrm_contact_member_merged_view", id: false, force: :cascade do |t|
    t.string   "member_status",                   limit: 255,   default: "NA"
    t.integer  "id",                              limit: 4,     default: 0,    null: false
    t.string   "display_name",                    limit: 128
    t.string   "last_name",                       limit: 64
    t.string   "first_name",                      limit: 64
    t.text     "service_type",                    limit: 65535
    t.integer  "service_status",                  limit: 4
    t.datetime "foundations_truth"
    t.datetime "foundations_freedom"
    t.datetime "foundations_service"
    t.datetime "foundations_community"
    t.datetime "memberDate"
    t.integer  "small_group_leader_147",          limit: 4
    t.string   "small_group_leader_name",         limit: 128
    t.string   "small_group_member_label_158",    limit: 255
    t.datetime "summer_conference_122"
    t.datetime "winter_conference_123"
    t.datetime "newcomer_lunch_124"
    t.datetime "fall_retreat_125"
    t.datetime "small_group_leader_retreat_126"
    t.datetime "learning_to_pray_for_others_127"
    t.integer  "tag_id",                          limit: 4
    t.text     "tithes",                          limit: 65535
    t.text     "sg_group_id",                     limit: 65535
  end

  create_table "civicrm_contact_member_tithes_view", id: false, force: :cascade do |t|
    t.decimal  "total_amount",             precision: 20, scale: 2
    t.datetime "receive_date"
    t.integer  "id",           limit: 4,                            default: 0, null: false
    t.string   "display_name", limit: 128
    t.string   "last_name",    limit: 64
    t.string   "first_name",   limit: 64
  end

  create_table "civicrm_contact_member_view", id: false, force: :cascade do |t|
    t.string   "member_status",                   limit: 255,   default: "NA"
    t.integer  "id",                              limit: 4,     default: 0,    null: false
    t.string   "display_name",                    limit: 128
    t.string   "last_name",                       limit: 64
    t.string   "first_name",                      limit: 64
    t.text     "service_type",                    limit: 65535
    t.integer  "service_status",                  limit: 4
    t.datetime "foundations_truth"
    t.datetime "foundations_freedom"
    t.datetime "foundations_service"
    t.datetime "foundations_community"
    t.datetime "memberDate"
    t.integer  "group_leader_115",                limit: 4
    t.integer  "small_group_leader_147",          limit: 4
    t.string   "small_group_member_label_158",    limit: 255
    t.datetime "summer_conference_122"
    t.datetime "winter_conference_123"
    t.datetime "newcomer_lunch_124"
    t.datetime "fall_retreat_125"
    t.datetime "small_group_leader_retreat_126"
    t.datetime "learning_to_pray_for_others_127"
    t.integer  "tag_id",                          limit: 4
  end

  create_table "civicrm_contact_prev_id", force: :cascade do |t|
    t.integer "contact_id", limit: 4, null: false
    t.integer "f1_id",      limit: 4
    t.integer "alf_id",     limit: 4
  end

  create_table "civicrm_contact_serving_view", id: false, force: :cascade do |t|
    t.integer "id",              limit: 4,     default: 0, null: false
    t.string  "display_name",    limit: 128
    t.string  "last_name",       limit: 64
    t.string  "first_name",      limit: 64
    t.text    "membership_type", limit: 65535
  end

  create_table "civicrm_contact_type", force: :cascade do |t|
    t.string  "name",        limit: 64
    t.string  "label",       limit: 64
    t.text    "description", limit: 65535
    t.string  "image_URL",   limit: 255
    t.integer "parent_id",   limit: 4
    t.integer "is_active",   limit: 1
    t.integer "is_reserved", limit: 1
  end

  add_index "civicrm_contact_type", ["name"], name: "contact_type", unique: true, using: :btree
  add_index "civicrm_contact_type", ["parent_id"], name: "FK_civicrm_contact_type_parent_id", using: :btree

  create_table "civicrm_contribution", force: :cascade do |t|
    t.integer  "contact_id",               limit: 4,                                            null: false
    t.integer  "financial_type_id",        limit: 4
    t.integer  "contribution_page_id",     limit: 4
    t.integer  "payment_instrument_id",    limit: 4
    t.datetime "receive_date"
    t.decimal  "non_deductible_amount",                  precision: 20, scale: 2, default: 0.0
    t.decimal  "total_amount",                           precision: 20, scale: 2,               null: false
    t.decimal  "fee_amount",                             precision: 20, scale: 2
    t.decimal  "net_amount",                             precision: 20, scale: 2
    t.string   "trxn_id",                  limit: 255
    t.string   "invoice_id",               limit: 255
    t.string   "currency",                 limit: 3
    t.datetime "cancel_date"
    t.text     "cancel_reason",            limit: 65535
    t.datetime "receipt_date"
    t.datetime "thankyou_date"
    t.string   "source",                   limit: 255
    t.text     "amount_level",             limit: 65535
    t.integer  "contribution_recur_id",    limit: 4
    t.integer  "is_test",                  limit: 1,                              default: 0
    t.integer  "is_pay_later",             limit: 1,                              default: 0
    t.integer  "contribution_status_id",   limit: 4,                              default: 1
    t.integer  "address_id",               limit: 4
    t.string   "check_number",             limit: 255
    t.integer  "campaign_id",              limit: 4
    t.decimal  "tax_amount",                             precision: 20, scale: 2
    t.string   "creditnote_id",            limit: 255
    t.datetime "revenue_recognition_date"
  end

  add_index "civicrm_contribution", ["address_id"], name: "FK_civicrm_contribution_address_id", using: :btree
  add_index "civicrm_contribution", ["campaign_id"], name: "FK_civicrm_contribution_campaign_id", using: :btree
  add_index "civicrm_contribution", ["check_number"], name: "check_number", using: :btree
  add_index "civicrm_contribution", ["contact_id"], name: "FK_civicrm_contribution_contact_id", using: :btree
  add_index "civicrm_contribution", ["contribution_page_id"], name: "FK_civicrm_contribution_contribution_page_id", using: :btree
  add_index "civicrm_contribution", ["contribution_recur_id"], name: "FK_civicrm_contribution_contribution_recur_id", using: :btree
  add_index "civicrm_contribution", ["contribution_status_id"], name: "index_contribution_status", using: :btree
  add_index "civicrm_contribution", ["creditnote_id"], name: "index_creditnote_id", using: :btree
  add_index "civicrm_contribution", ["financial_type_id"], name: "FK_civicrm_contribution_financial_type_id", using: :btree
  add_index "civicrm_contribution", ["invoice_id"], name: "UI_contrib_invoice_id", unique: true, using: :btree
  add_index "civicrm_contribution", ["payment_instrument_id"], name: "UI_contrib_payment_instrument_id", using: :btree
  add_index "civicrm_contribution", ["receive_date"], name: "received_date", using: :btree
  add_index "civicrm_contribution", ["source"], name: "index_source", using: :btree
  add_index "civicrm_contribution", ["total_amount", "receive_date"], name: "index_total_amount_receive_date", using: :btree
  add_index "civicrm_contribution", ["trxn_id"], name: "UI_contrib_trxn_id", unique: true, using: :btree

  create_table "civicrm_contribution_page", force: :cascade do |t|
    t.string   "title",                    limit: 255
    t.text     "intro_text",               limit: 65535
    t.integer  "financial_type_id",        limit: 4
    t.string   "payment_processor",        limit: 128
    t.integer  "is_credit_card_only",      limit: 1,                              default: 0
    t.integer  "is_monetary",              limit: 1,                              default: 1
    t.integer  "is_recur",                 limit: 1,                              default: 0
    t.integer  "is_confirm_enabled",       limit: 1,                              default: 1
    t.string   "recur_frequency_unit",     limit: 128
    t.integer  "is_recur_interval",        limit: 1,                              default: 0
    t.integer  "is_recur_installments",    limit: 1,                              default: 0
    t.integer  "adjust_recur_start_date",  limit: 1,                              default: 0, null: false
    t.integer  "is_pay_later",             limit: 1,                              default: 0
    t.text     "pay_later_text",           limit: 65535
    t.text     "pay_later_receipt",        limit: 65535
    t.integer  "is_partial_payment",       limit: 1,                              default: 0
    t.string   "initial_amount_label",     limit: 255
    t.text     "initial_amount_help_text", limit: 65535
    t.decimal  "min_initial_amount",                     precision: 20, scale: 2
    t.integer  "is_allow_other_amount",    limit: 1,                              default: 0
    t.integer  "default_amount_id",        limit: 4
    t.decimal  "min_amount",                             precision: 20, scale: 2
    t.decimal  "max_amount",                             precision: 20, scale: 2
    t.decimal  "goal_amount",                            precision: 20, scale: 2
    t.string   "thankyou_title",           limit: 255
    t.text     "thankyou_text",            limit: 65535
    t.text     "thankyou_footer",          limit: 65535
    t.integer  "is_email_receipt",         limit: 1,                              default: 0
    t.string   "receipt_from_name",        limit: 255
    t.string   "receipt_from_email",       limit: 255
    t.string   "cc_receipt",               limit: 255
    t.string   "bcc_receipt",              limit: 255
    t.text     "receipt_text",             limit: 65535
    t.integer  "is_active",                limit: 1
    t.text     "footer_text",              limit: 65535
    t.integer  "amount_block_is_active",   limit: 1,                              default: 1
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "created_id",               limit: 4
    t.datetime "created_date"
    t.string   "currency",                 limit: 3
    t.integer  "campaign_id",              limit: 4
    t.integer  "is_share",                 limit: 1,                              default: 1
    t.integer  "is_billing_required",      limit: 1,                              default: 0
  end

  add_index "civicrm_contribution_page", ["campaign_id"], name: "FK_civicrm_contribution_page_campaign_id", using: :btree
  add_index "civicrm_contribution_page", ["created_id"], name: "FK_civicrm_contribution_page_created_id", using: :btree
  add_index "civicrm_contribution_page", ["financial_type_id"], name: "FK_civicrm_contribution_page_financial_type_id", using: :btree

  create_table "civicrm_contribution_product", force: :cascade do |t|
    t.integer "product_id",        limit: 4,     null: false
    t.integer "contribution_id",   limit: 4,     null: false
    t.string  "product_option",    limit: 255
    t.integer "quantity",          limit: 4
    t.date    "fulfilled_date"
    t.date    "start_date"
    t.date    "end_date"
    t.text    "comment",           limit: 65535
    t.integer "financial_type_id", limit: 4
  end

  add_index "civicrm_contribution_product", ["contribution_id"], name: "FK_civicrm_contribution_product_contribution_id", using: :btree
  add_index "civicrm_contribution_product", ["financial_type_id"], name: "FK_civicrm_contribution_product_financial_type_id", using: :btree

  create_table "civicrm_contribution_recur", force: :cascade do |t|
    t.integer  "contact_id",                   limit: 4,                                              null: false
    t.decimal  "amount",                                   precision: 20, scale: 2,                   null: false
    t.string   "currency",                     limit: 3
    t.string   "frequency_unit",               limit: 8,                            default: "month"
    t.integer  "frequency_interval",           limit: 4,                                              null: false
    t.integer  "installments",                 limit: 4
    t.datetime "start_date",                                                                          null: false
    t.datetime "create_date",                                                                         null: false
    t.datetime "modified_date"
    t.datetime "cancel_date"
    t.datetime "end_date"
    t.string   "processor_id",                 limit: 255
    t.string   "trxn_id",                      limit: 255
    t.string   "invoice_id",                   limit: 255
    t.integer  "contribution_status_id",       limit: 4,                            default: 1
    t.integer  "is_test",                      limit: 1,                            default: 0
    t.integer  "cycle_day",                    limit: 4,                            default: 1,       null: false
    t.datetime "next_sched_contribution_date"
    t.integer  "failure_count",                limit: 4,                            default: 0
    t.datetime "failure_retry_date"
    t.integer  "auto_renew",                   limit: 1,                            default: 0,       null: false
    t.integer  "payment_processor_id",         limit: 4
    t.integer  "financial_type_id",            limit: 4
    t.integer  "payment_instrument_id",        limit: 4
    t.integer  "campaign_id",                  limit: 4
    t.integer  "is_email_receipt",             limit: 1,                            default: 1
    t.integer  "payment_token_id",             limit: 4
  end

  add_index "civicrm_contribution_recur", ["campaign_id"], name: "FK_civicrm_contribution_recur_campaign_id", using: :btree
  add_index "civicrm_contribution_recur", ["contact_id"], name: "FK_civicrm_contribution_recur_contact_id", using: :btree
  add_index "civicrm_contribution_recur", ["contribution_status_id"], name: "index_contribution_status", using: :btree
  add_index "civicrm_contribution_recur", ["financial_type_id"], name: "FK_civicrm_contribution_recur_financial_type_id", using: :btree
  add_index "civicrm_contribution_recur", ["invoice_id"], name: "UI_contrib_invoice_id", unique: true, using: :btree
  add_index "civicrm_contribution_recur", ["payment_instrument_id"], name: "UI_contribution_recur_payment_instrument_id", using: :btree
  add_index "civicrm_contribution_recur", ["payment_processor_id"], name: "FK_civicrm_contribution_recur_payment_processor_id", using: :btree
  add_index "civicrm_contribution_recur", ["payment_token_id"], name: "FK_civicrm_contribution_recur_payment_token_id", using: :btree
  add_index "civicrm_contribution_recur", ["trxn_id"], name: "UI_contrib_trxn_id", unique: true, using: :btree

  create_table "civicrm_contribution_soft", force: :cascade do |t|
    t.integer "contribution_id",     limit: 4,                                        null: false
    t.integer "contact_id",          limit: 4,                                        null: false
    t.decimal "amount",                          precision: 20, scale: 2,             null: false
    t.string  "currency",            limit: 3
    t.integer "pcp_id",              limit: 4
    t.integer "pcp_display_in_roll", limit: 1,                            default: 0
    t.string  "pcp_roll_nickname",   limit: 255
    t.string  "pcp_personal_note",   limit: 255
    t.integer "soft_credit_type_id", limit: 4
  end

  add_index "civicrm_contribution_soft", ["contact_id"], name: "FK_civicrm_contribution_soft_contact_id", using: :btree
  add_index "civicrm_contribution_soft", ["contribution_id"], name: "FK_civicrm_contribution_soft_contribution_id", using: :btree
  add_index "civicrm_contribution_soft", ["pcp_id"], name: "index_id", using: :btree

  create_table "civicrm_contribution_widget", force: :cascade do |t|
    t.integer "contribution_page_id", limit: 4
    t.integer "is_active",            limit: 1
    t.string  "title",                limit: 255
    t.string  "url_logo",             limit: 255
    t.string  "button_title",         limit: 255
    t.text    "about",                limit: 65535
    t.string  "url_homepage",         limit: 255
    t.string  "color_title",          limit: 10
    t.string  "color_button",         limit: 10
    t.string  "color_bar",            limit: 10
    t.string  "color_main_text",      limit: 10
    t.string  "color_main",           limit: 10
    t.string  "color_main_bg",        limit: 10
    t.string  "color_bg",             limit: 10
    t.string  "color_about_link",     limit: 10
    t.string  "color_homepage_link",  limit: 10
  end

  add_index "civicrm_contribution_widget", ["contribution_page_id"], name: "FK_civicrm_contribution_widget_contribution_page_id", using: :btree

  create_table "civicrm_country", force: :cascade do |t|
    t.string  "name",                    limit: 64
    t.string  "iso_code",                limit: 2
    t.string  "country_code",            limit: 4
    t.integer "address_format_id",       limit: 4
    t.string  "idd_prefix",              limit: 4
    t.string  "ndd_prefix",              limit: 4
    t.integer "region_id",               limit: 4,              null: false
    t.integer "is_province_abbreviated", limit: 1,  default: 0
  end

  add_index "civicrm_country", ["address_format_id"], name: "FK_civicrm_country_address_format_id", using: :btree
  add_index "civicrm_country", ["name", "iso_code"], name: "UI_name_iso_code", unique: true, using: :btree
  add_index "civicrm_country", ["region_id"], name: "FK_civicrm_country_region_id", using: :btree

  create_table "civicrm_county", force: :cascade do |t|
    t.string  "name",              limit: 64
    t.string  "abbreviation",      limit: 4
    t.integer "state_province_id", limit: 4,  null: false
  end

  add_index "civicrm_county", ["name", "state_province_id"], name: "UI_name_state_id", unique: true, using: :btree
  add_index "civicrm_county", ["state_province_id"], name: "FK_civicrm_county_state_province_id", using: :btree

  create_table "civicrm_currency", force: :cascade do |t|
    t.string "name",         limit: 64
    t.string "symbol",       limit: 8
    t.string "numeric_code", limit: 3
    t.string "full_name",    limit: 64
  end

  create_table "civicrm_custom_field", force: :cascade do |t|
    t.integer "custom_group_id",  limit: 4,                 null: false
    t.string  "name",             limit: 64
    t.string  "label",            limit: 255,               null: false
    t.string  "data_type",        limit: 16,                null: false
    t.string  "html_type",        limit: 32,                null: false
    t.string  "default_value",    limit: 255
    t.integer "is_required",      limit: 1
    t.integer "is_searchable",    limit: 1
    t.integer "is_search_range",  limit: 1,     default: 0
    t.integer "weight",           limit: 4,     default: 1, null: false
    t.text    "help_pre",         limit: 65535
    t.text    "help_post",        limit: 65535
    t.string  "mask",             limit: 64
    t.string  "attributes",       limit: 255
    t.string  "javascript",       limit: 255
    t.integer "is_active",        limit: 1
    t.integer "is_view",          limit: 1
    t.integer "options_per_line", limit: 4
    t.integer "text_length",      limit: 4
    t.integer "start_date_years", limit: 4
    t.integer "end_date_years",   limit: 4
    t.string  "date_format",      limit: 64
    t.integer "time_format",      limit: 4
    t.integer "note_columns",     limit: 4
    t.integer "note_rows",        limit: 4
    t.string  "column_name",      limit: 255
    t.integer "option_group_id",  limit: 4
    t.string  "filter",           limit: 255
    t.integer "in_selector",      limit: 1,     default: 0
  end

  add_index "civicrm_custom_field", ["custom_group_id"], name: "FK_civicrm_custom_field_custom_group_id", using: :btree
  add_index "civicrm_custom_field", ["label", "custom_group_id"], name: "UI_label_custom_group_id", unique: true, using: :btree
  add_index "civicrm_custom_field", ["name", "custom_group_id"], name: "UI_name_custom_group_id", unique: true, using: :btree

  create_table "civicrm_custom_group", force: :cascade do |t|
    t.string   "name",                        limit: 64
    t.string   "title",                       limit: 64,                        null: false
    t.string   "extends",                     limit: 255,   default: "Contact"
    t.integer  "extends_entity_column_id",    limit: 4
    t.string   "extends_entity_column_value", limit: 255
    t.string   "style",                       limit: 15
    t.integer  "collapse_display",            limit: 4,     default: 0
    t.text     "help_pre",                    limit: 65535
    t.text     "help_post",                   limit: 65535
    t.integer  "weight",                      limit: 4,     default: 1,         null: false
    t.integer  "is_active",                   limit: 1
    t.string   "table_name",                  limit: 255
    t.integer  "is_multiple",                 limit: 1
    t.integer  "min_multiple",                limit: 4
    t.integer  "max_multiple",                limit: 4
    t.integer  "collapse_adv_display",        limit: 4,     default: 0
    t.integer  "created_id",                  limit: 4
    t.datetime "created_date"
    t.integer  "is_reserved",                 limit: 1,     default: 0
    t.boolean  "is_public",                                 default: true
  end

  add_index "civicrm_custom_group", ["created_id"], name: "FK_civicrm_custom_group_created_id", using: :btree
  add_index "civicrm_custom_group", ["name", "extends"], name: "UI_name_extends", unique: true, using: :btree
  add_index "civicrm_custom_group", ["title", "extends"], name: "UI_title_extends", unique: true, using: :btree

  create_table "civicrm_cxn", force: :cascade do |t|
    t.string   "app_guid",      limit: 128
    t.text     "app_meta",      limit: 65535
    t.string   "cxn_guid",      limit: 128
    t.text     "secret",        limit: 65535
    t.text     "perm",          limit: 65535
    t.text     "options",       limit: 65535
    t.integer  "is_active",     limit: 1,     default: 1
    t.datetime "created_date"
    t.datetime "modified_date"
    t.datetime "fetched_date"
  end

  add_index "civicrm_cxn", ["app_guid"], name: "UI_appid", unique: true, using: :btree
  add_index "civicrm_cxn", ["cxn_guid"], name: "UI_keypair_cxnid", unique: true, using: :btree

  create_table "civicrm_dashboard", force: :cascade do |t|
    t.integer "domain_id",           limit: 4,                null: false
    t.string  "name",                limit: 64
    t.string  "label",               limit: 255
    t.string  "url",                 limit: 255
    t.string  "permission",          limit: 255
    t.string  "permission_operator", limit: 3
    t.string  "fullscreen_url",      limit: 255
    t.integer "is_active",           limit: 1,   default: 0
    t.integer "is_reserved",         limit: 1,   default: 0
    t.integer "cache_minutes",       limit: 4,   default: 60, null: false
  end

  add_index "civicrm_dashboard", ["domain_id"], name: "FK_civicrm_dashboard_domain_id", using: :btree

  create_table "civicrm_dashboard_contact", force: :cascade do |t|
    t.integer "dashboard_id", limit: 4,             null: false
    t.integer "contact_id",   limit: 4,             null: false
    t.integer "column_no",    limit: 1, default: 0
    t.integer "is_active",    limit: 1, default: 0
    t.integer "weight",       limit: 4, default: 0
  end

  add_index "civicrm_dashboard_contact", ["contact_id"], name: "FK_civicrm_dashboard_contact_contact_id", using: :btree
  add_index "civicrm_dashboard_contact", ["dashboard_id", "contact_id"], name: "index_dashboard_id_contact_id", unique: true, using: :btree

  create_table "civicrm_dedupe_exception", force: :cascade do |t|
    t.integer "contact_id1", limit: 4
    t.integer "contact_id2", limit: 4
  end

  add_index "civicrm_dedupe_exception", ["contact_id1", "contact_id2"], name: "UI_contact_id1_contact_id2", unique: true, using: :btree
  add_index "civicrm_dedupe_exception", ["contact_id2"], name: "FK_civicrm_dedupe_exception_contact_id2", using: :btree

  create_table "civicrm_dedupe_rule", force: :cascade do |t|
    t.integer "dedupe_rule_group_id", limit: 4,  null: false
    t.string  "rule_table",           limit: 64, null: false
    t.string  "rule_field",           limit: 64, null: false
    t.integer "rule_length",          limit: 4
    t.integer "rule_weight",          limit: 4,  null: false
  end

  add_index "civicrm_dedupe_rule", ["dedupe_rule_group_id"], name: "FK_civicrm_dedupe_rule_dedupe_rule_group_id", using: :btree

  create_table "civicrm_dedupe_rule_group", force: :cascade do |t|
    t.string  "contact_type", limit: 12
    t.integer "threshold",    limit: 4,   null: false
    t.string  "used",         limit: 12,  null: false
    t.string  "name",         limit: 64
    t.string  "title",        limit: 255
    t.integer "is_reserved",  limit: 1
  end

  create_table "civicrm_discount", force: :cascade do |t|
    t.string  "entity_table", limit: 64
    t.integer "entity_id",    limit: 4,  null: false
    t.integer "price_set_id", limit: 4,  null: false
    t.date    "start_date"
    t.date    "end_date"
  end

  add_index "civicrm_discount", ["entity_table", "entity_id", "price_set_id"], name: "index_entity_option_id", using: :btree
  add_index "civicrm_discount", ["entity_table", "entity_id"], name: "index_entity", using: :btree
  add_index "civicrm_discount", ["price_set_id"], name: "FK_civicrm_discount_price_set_id", using: :btree

  create_table "civicrm_domain", force: :cascade do |t|
    t.string  "name",                  limit: 64
    t.string  "description",           limit: 255
    t.string  "version",               limit: 32
    t.integer "contact_id",            limit: 4
    t.text    "locales",               limit: 65535
    t.text    "locale_custom_strings", limit: 65535
  end

  add_index "civicrm_domain", ["contact_id"], name: "FK_civicrm_domain_contact_id", using: :btree
  add_index "civicrm_domain", ["name"], name: "UI_name", unique: true, using: :btree

  create_table "civicrm_email", force: :cascade do |t|
    t.integer  "contact_id",       limit: 4
    t.integer  "location_type_id", limit: 4
    t.string   "email",            limit: 254
    t.integer  "is_primary",       limit: 1,     default: 0
    t.integer  "is_billing",       limit: 1,     default: 0
    t.integer  "on_hold",          limit: 1,     default: 0, null: false
    t.integer  "is_bulkmail",      limit: 1,     default: 0, null: false
    t.datetime "hold_date"
    t.datetime "reset_date"
    t.text     "signature_text",   limit: 65535
    t.text     "signature_html",   limit: 65535
  end

  add_index "civicrm_email", ["contact_id"], name: "FK_civicrm_email_contact_id", using: :btree
  add_index "civicrm_email", ["email"], name: "UI_email", using: :btree
  add_index "civicrm_email", ["is_billing"], name: "index_is_billing", using: :btree
  add_index "civicrm_email", ["is_primary"], name: "index_is_primary", using: :btree
  add_index "civicrm_email", ["location_type_id"], name: "index_location_type", using: :btree

  create_table "civicrm_entity_batch", force: :cascade do |t|
    t.string  "entity_table", limit: 64
    t.integer "entity_id",    limit: 4,  null: false
    t.integer "batch_id",     limit: 4,  null: false
  end

  add_index "civicrm_entity_batch", ["batch_id", "entity_id", "entity_table"], name: "UI_batch_entity", unique: true, using: :btree
  add_index "civicrm_entity_batch", ["entity_table", "entity_id"], name: "index_entity", using: :btree

  create_table "civicrm_entity_file", force: :cascade do |t|
    t.string  "entity_table", limit: 64
    t.integer "entity_id",    limit: 4,  null: false
    t.integer "file_id",      limit: 4,  null: false
  end

  add_index "civicrm_entity_file", ["entity_table", "entity_id", "file_id"], name: "index_entity_file_id", using: :btree
  add_index "civicrm_entity_file", ["entity_table", "entity_id"], name: "index_entity", using: :btree
  add_index "civicrm_entity_file", ["file_id"], name: "FK_civicrm_entity_file_file_id", using: :btree

  create_table "civicrm_entity_financial_account", force: :cascade do |t|
    t.string  "entity_table",         limit: 64, null: false
    t.integer "entity_id",            limit: 4,  null: false
    t.integer "account_relationship", limit: 4,  null: false
    t.integer "financial_account_id", limit: 4,  null: false
  end

  add_index "civicrm_entity_financial_account", ["entity_id", "entity_table", "account_relationship"], name: "index_entity_id_entity_table_account_relationship", unique: true, using: :btree
  add_index "civicrm_entity_financial_account", ["financial_account_id"], name: "FK_civicrm_entity_financial_account_financial_account_id", using: :btree

  create_table "civicrm_entity_financial_trxn", force: :cascade do |t|
    t.string  "entity_table",      limit: 64,                          null: false
    t.integer "entity_id",         limit: 4,                           null: false
    t.integer "financial_trxn_id", limit: 4
    t.decimal "amount",                       precision: 20, scale: 2, null: false
  end

  add_index "civicrm_entity_financial_trxn", ["entity_id"], name: "UI_entity_financial_trxn_entity_id", using: :btree
  add_index "civicrm_entity_financial_trxn", ["entity_table"], name: "UI_entity_financial_trxn_entity_table", using: :btree
  add_index "civicrm_entity_financial_trxn", ["financial_trxn_id"], name: "FK_civicrm_entity_financial_trxn_financial_trxn_id", using: :btree

  create_table "civicrm_entity_tag", force: :cascade do |t|
    t.string  "entity_table", limit: 64
    t.integer "entity_id",    limit: 4,  null: false
    t.integer "tag_id",       limit: 4,  null: false
  end

  add_index "civicrm_entity_tag", ["entity_id", "entity_table", "tag_id"], name: "UI_entity_id_entity_table_tag_id", unique: true, using: :btree
  add_index "civicrm_entity_tag", ["tag_id"], name: "FK_civicrm_entity_tag_tag_id", using: :btree

  create_table "civicrm_event", force: :cascade do |t|
    t.string   "title",                         limit: 255
    t.text     "summary",                       limit: 65535
    t.text     "description",                   limit: 65535
    t.integer  "event_type_id",                 limit: 4,                              default: 0
    t.integer  "participant_listing_id",        limit: 4,                              default: 0
    t.integer  "is_public",                     limit: 1,                              default: 1
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "is_online_registration",        limit: 1,                              default: 0
    t.string   "registration_link_text",        limit: 255
    t.datetime "registration_start_date"
    t.datetime "registration_end_date"
    t.integer  "max_participants",              limit: 4
    t.text     "event_full_text",               limit: 65535
    t.integer  "is_monetary",                   limit: 1,                              default: 0
    t.integer  "financial_type_id",             limit: 4
    t.string   "payment_processor",             limit: 128
    t.integer  "is_map",                        limit: 1,                              default: 0
    t.integer  "is_active",                     limit: 1,                              default: 0
    t.string   "fee_label",                     limit: 255
    t.integer  "is_show_location",              limit: 1,                              default: 1
    t.integer  "loc_block_id",                  limit: 4
    t.integer  "default_role_id",               limit: 4,                              default: 1
    t.text     "intro_text",                    limit: 65535
    t.text     "footer_text",                   limit: 65535
    t.string   "confirm_title",                 limit: 255
    t.text     "confirm_text",                  limit: 65535
    t.text     "confirm_footer_text",           limit: 65535
    t.integer  "is_email_confirm",              limit: 1,                              default: 0
    t.text     "confirm_email_text",            limit: 65535
    t.string   "confirm_from_name",             limit: 255
    t.string   "confirm_from_email",            limit: 255
    t.string   "cc_confirm",                    limit: 255
    t.string   "bcc_confirm",                   limit: 255
    t.integer  "default_fee_id",                limit: 4
    t.integer  "default_discount_fee_id",       limit: 4
    t.string   "thankyou_title",                limit: 255
    t.text     "thankyou_text",                 limit: 65535
    t.text     "thankyou_footer_text",          limit: 65535
    t.integer  "is_pay_later",                  limit: 1,                              default: 0
    t.text     "pay_later_text",                limit: 65535
    t.text     "pay_later_receipt",             limit: 65535
    t.integer  "is_partial_payment",            limit: 1,                              default: 0
    t.string   "initial_amount_label",          limit: 255
    t.text     "initial_amount_help_text",      limit: 65535
    t.decimal  "min_initial_amount",                          precision: 20, scale: 2
    t.integer  "is_multiple_registrations",     limit: 1,                              default: 0
    t.integer  "max_additional_participants",   limit: 4,                              default: 0
    t.integer  "allow_same_participant_emails", limit: 1,                              default: 0
    t.integer  "has_waitlist",                  limit: 1
    t.integer  "requires_approval",             limit: 1
    t.integer  "expiration_time",               limit: 4
    t.text     "waitlist_text",                 limit: 65535
    t.text     "approval_req_text",             limit: 65535
    t.integer  "is_template",                   limit: 1,                              default: 0, null: false
    t.string   "template_title",                limit: 255
    t.integer  "created_id",                    limit: 4
    t.datetime "created_date"
    t.string   "currency",                      limit: 3
    t.integer  "campaign_id",                   limit: 4
    t.integer  "is_share",                      limit: 1,                              default: 1
    t.integer  "is_confirm_enabled",            limit: 1,                              default: 1
    t.integer  "parent_event_id",               limit: 4
    t.integer  "slot_label_id",                 limit: 4
    t.integer  "dedupe_rule_group_id",          limit: 4
    t.integer  "is_billing_required",           limit: 1,                              default: 0
    t.integer  "selfcancelxfer_time",           limit: 4,                              default: 0
    t.integer  "allow_selfcancelxfer",          limit: 1,                              default: 0
  end

  add_index "civicrm_event", ["campaign_id"], name: "FK_civicrm_event_campaign_id", using: :btree
  add_index "civicrm_event", ["created_id"], name: "FK_civicrm_event_created_id", using: :btree
  add_index "civicrm_event", ["dedupe_rule_group_id"], name: "FK_civicrm_event_dedupe_rule_group_id", using: :btree
  add_index "civicrm_event", ["event_type_id"], name: "index_event_type_id", using: :btree
  add_index "civicrm_event", ["loc_block_id"], name: "FK_civicrm_event_loc_block_id", using: :btree
  add_index "civicrm_event", ["parent_event_id"], name: "index_parent_event_id", using: :btree
  add_index "civicrm_event", ["participant_listing_id"], name: "index_participant_listing_id", using: :btree

  create_table "civicrm_event_carts", force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "completed", limit: 1, default: 0
  end

  add_index "civicrm_event_carts", ["user_id"], name: "FK_civicrm_event_carts_user_id", using: :btree

  create_table "civicrm_events_in_carts", force: :cascade do |t|
    t.integer "event_id",      limit: 4
    t.integer "event_cart_id", limit: 4
  end

  add_index "civicrm_events_in_carts", ["event_cart_id"], name: "FK_civicrm_events_in_carts_event_cart_id", using: :btree
  add_index "civicrm_events_in_carts", ["event_id"], name: "FK_civicrm_events_in_carts_event_id", using: :btree

  create_table "civicrm_extension", force: :cascade do |t|
    t.string  "type",           limit: 8,               null: false
    t.string  "full_name",      limit: 255,             null: false
    t.string  "name",           limit: 255
    t.string  "label",          limit: 255
    t.string  "file",           limit: 255
    t.string  "schema_version", limit: 63
    t.integer "is_active",      limit: 1,   default: 1
  end

  add_index "civicrm_extension", ["full_name"], name: "UI_extension_full_name", unique: true, using: :btree
  add_index "civicrm_extension", ["name"], name: "UI_extension_name", using: :btree

  create_table "civicrm_file", force: :cascade do |t|
    t.integer  "file_type_id", limit: 4
    t.string   "mime_type",    limit: 255
    t.string   "uri",          limit: 255
    t.binary   "document",     limit: 16777215
    t.string   "description",  limit: 255
    t.datetime "upload_date"
  end

  create_table "civicrm_financial_account", force: :cascade do |t|
    t.string  "name",                      limit: 255,                                      null: false
    t.integer "contact_id",                limit: 4
    t.integer "financial_account_type_id", limit: 4,                            default: 3, null: false
    t.string  "accounting_code",           limit: 64
    t.string  "account_type_code",         limit: 64
    t.string  "description",               limit: 255
    t.integer "parent_id",                 limit: 4
    t.integer "is_header_account",         limit: 1,                            default: 0
    t.integer "is_deductible",             limit: 1,                            default: 1
    t.integer "is_tax",                    limit: 1,                            default: 0
    t.decimal "tax_rate",                              precision: 10, scale: 8
    t.integer "is_reserved",               limit: 1
    t.integer "is_active",                 limit: 1
    t.integer "is_default",                limit: 1
  end

  add_index "civicrm_financial_account", ["contact_id"], name: "FK_civicrm_financial_account_contact_id", using: :btree
  add_index "civicrm_financial_account", ["name"], name: "UI_name", unique: true, using: :btree
  add_index "civicrm_financial_account", ["parent_id"], name: "FK_civicrm_financial_account_parent_id", using: :btree

  create_table "civicrm_financial_item", force: :cascade do |t|
    t.datetime "created_date",                                                            null: false
    t.datetime "transaction_date",                                                        null: false
    t.integer  "contact_id",           limit: 4,                                          null: false
    t.string   "description",          limit: 255
    t.decimal  "amount",                           precision: 20, scale: 2, default: 0.0, null: false
    t.string   "currency",             limit: 3
    t.integer  "financial_account_id", limit: 4
    t.integer  "status_id",            limit: 4
    t.string   "entity_table",         limit: 64
    t.integer  "entity_id",            limit: 4
  end

  add_index "civicrm_financial_item", ["contact_id"], name: "FK_civicrm_financial_item_contact_id", using: :btree
  add_index "civicrm_financial_item", ["created_date"], name: "IX_created_date", using: :btree
  add_index "civicrm_financial_item", ["entity_id", "entity_table"], name: "index_entity_id_entity_table", using: :btree
  add_index "civicrm_financial_item", ["financial_account_id"], name: "FK_civicrm_financial_item_financial_account_id", using: :btree
  add_index "civicrm_financial_item", ["transaction_date"], name: "IX_transaction_date", using: :btree

  create_table "civicrm_financial_trxn", force: :cascade do |t|
    t.integer  "from_financial_account_id", limit: 4
    t.integer  "to_financial_account_id",   limit: 4
    t.datetime "trxn_date"
    t.decimal  "total_amount",                          precision: 20, scale: 2,             null: false
    t.decimal  "fee_amount",                            precision: 20, scale: 2
    t.decimal  "net_amount",                            precision: 20, scale: 2
    t.string   "currency",                  limit: 3
    t.string   "trxn_id",                   limit: 255
    t.string   "trxn_result_code",          limit: 255
    t.integer  "status_id",                 limit: 4
    t.integer  "payment_processor_id",      limit: 4
    t.integer  "payment_instrument_id",     limit: 4
    t.integer  "card_type_id",              limit: 4
    t.string   "check_number",              limit: 255
    t.string   "pan_truncation",            limit: 4
    t.integer  "is_payment",                limit: 1,                            default: 0
  end

  add_index "civicrm_financial_trxn", ["check_number"], name: "UI_ftrxn_check_number", using: :btree
  add_index "civicrm_financial_trxn", ["from_financial_account_id"], name: "FK_civicrm_financial_trxn_from_financial_account_id", using: :btree
  add_index "civicrm_financial_trxn", ["payment_instrument_id"], name: "UI_ftrxn_payment_instrument_id", using: :btree
  add_index "civicrm_financial_trxn", ["payment_processor_id"], name: "FK_civicrm_financial_trxn_payment_processor_id", using: :btree
  add_index "civicrm_financial_trxn", ["to_financial_account_id"], name: "FK_civicrm_financial_trxn_to_financial_account_id", using: :btree
  add_index "civicrm_financial_trxn", ["trxn_id"], name: "index_trxn_id", using: :btree

  create_table "civicrm_financial_type", force: :cascade do |t|
    t.string  "name",          limit: 64,              null: false
    t.string  "description",   limit: 255
    t.integer "is_deductible", limit: 1,   default: 1
    t.integer "is_reserved",   limit: 1
    t.integer "is_active",     limit: 1
  end

  add_index "civicrm_financial_type", ["id"], name: "UI_id", unique: true, using: :btree

  create_table "civicrm_grant", force: :cascade do |t|
    t.integer "contact_id",                limit: 4,                              null: false
    t.date    "application_received_date"
    t.date    "decision_date"
    t.date    "money_transfer_date"
    t.date    "grant_due_date"
    t.integer "grant_report_received",     limit: 1
    t.integer "grant_type_id",             limit: 4,                              null: false
    t.decimal "amount_total",                            precision: 20, scale: 2, null: false
    t.decimal "amount_requested",                        precision: 20, scale: 2
    t.decimal "amount_granted",                          precision: 20, scale: 2
    t.string  "currency",                  limit: 3,                              null: false
    t.text    "rationale",                 limit: 65535
    t.integer "status_id",                 limit: 4,                              null: false
    t.integer "financial_type_id",         limit: 4
  end

  add_index "civicrm_grant", ["contact_id"], name: "FK_civicrm_grant_contact_id", using: :btree
  add_index "civicrm_grant", ["financial_type_id"], name: "FK_civicrm_grant_financial_type_id", using: :btree
  add_index "civicrm_grant", ["grant_type_id"], name: "index_grant_type_id", using: :btree
  add_index "civicrm_grant", ["status_id"], name: "index_status_id", using: :btree

  create_table "civicrm_group", force: :cascade do |t|
    t.string   "name",            limit: 64
    t.string   "title",           limit: 64
    t.text     "description",     limit: 65535
    t.string   "source",          limit: 64
    t.integer  "saved_search_id", limit: 4
    t.integer  "is_active",       limit: 1
    t.string   "visibility",      limit: 24,    default: "User and User Admin Only"
    t.text     "where_clause",    limit: 65535
    t.text     "select_tables",   limit: 65535
    t.text     "where_tables",    limit: 65535
    t.string   "group_type",      limit: 128
    t.datetime "cache_date"
    t.datetime "refresh_date"
    t.text     "parents",         limit: 65535
    t.text     "children",        limit: 65535
    t.integer  "is_hidden",       limit: 1,     default: 0
    t.integer  "is_reserved",     limit: 1,     default: 0
    t.integer  "created_id",      limit: 4
    t.integer  "modified_id",     limit: 4
  end

  add_index "civicrm_group", ["created_id"], name: "FK_civicrm_group_created_id", using: :btree
  add_index "civicrm_group", ["group_type"], name: "index_group_type", using: :btree
  add_index "civicrm_group", ["modified_id"], name: "FK_civicrm_group_modified_id", using: :btree
  add_index "civicrm_group", ["name"], name: "UI_name", unique: true, using: :btree
  add_index "civicrm_group", ["saved_search_id"], name: "FK_civicrm_group_saved_search_id", using: :btree
  add_index "civicrm_group", ["title"], name: "UI_title", unique: true, using: :btree

  create_table "civicrm_group_contact", force: :cascade do |t|
    t.integer "group_id",    limit: 4, null: false
    t.integer "contact_id",  limit: 4, null: false
    t.string  "status",      limit: 8
    t.integer "location_id", limit: 4
    t.integer "email_id",    limit: 4
  end

  add_index "civicrm_group_contact", ["contact_id", "group_id"], name: "UI_contact_group", unique: true, using: :btree
  add_index "civicrm_group_contact", ["email_id"], name: "FK_civicrm_group_contact_email_id", using: :btree
  add_index "civicrm_group_contact", ["group_id"], name: "FK_civicrm_group_contact_group_id", using: :btree
  add_index "civicrm_group_contact", ["location_id"], name: "FK_civicrm_group_contact_location_id", using: :btree

  create_table "civicrm_group_contact_cache", force: :cascade do |t|
    t.integer "group_id",   limit: 4, null: false
    t.integer "contact_id", limit: 4, null: false
  end

  add_index "civicrm_group_contact_cache", ["contact_id", "group_id"], name: "UI_contact_group", unique: true, using: :btree
  add_index "civicrm_group_contact_cache", ["group_id"], name: "FK_civicrm_group_contact_cache_group_id", using: :btree

  create_table "civicrm_group_nesting", force: :cascade do |t|
    t.integer "child_group_id",  limit: 4, null: false
    t.integer "parent_group_id", limit: 4, null: false
  end

  add_index "civicrm_group_nesting", ["child_group_id"], name: "FK_civicrm_group_nesting_child_group_id", using: :btree
  add_index "civicrm_group_nesting", ["parent_group_id"], name: "FK_civicrm_group_nesting_parent_group_id", using: :btree

  create_table "civicrm_group_organization", force: :cascade do |t|
    t.integer "group_id",        limit: 4, null: false
    t.integer "organization_id", limit: 4, null: false
  end

  add_index "civicrm_group_organization", ["group_id", "organization_id"], name: "UI_group_organization", unique: true, using: :btree
  add_index "civicrm_group_organization", ["organization_id"], name: "FK_civicrm_group_organization_organization_id", using: :btree

  create_table "civicrm_im", force: :cascade do |t|
    t.integer "contact_id",       limit: 4
    t.integer "location_type_id", limit: 4
    t.string  "name",             limit: 64
    t.integer "provider_id",      limit: 4
    t.integer "is_primary",       limit: 1,  default: 0
    t.integer "is_billing",       limit: 1,  default: 0
  end

  add_index "civicrm_im", ["contact_id"], name: "FK_civicrm_im_contact_id", using: :btree
  add_index "civicrm_im", ["is_billing"], name: "index_is_billing", using: :btree
  add_index "civicrm_im", ["is_primary"], name: "index_is_primary", using: :btree
  add_index "civicrm_im", ["location_type_id"], name: "index_location_type", using: :btree
  add_index "civicrm_im", ["provider_id"], name: "UI_provider_id", using: :btree

  create_table "civicrm_install_canary", id: false, force: :cascade do |t|
    t.integer "id", limit: 4, null: false
  end

  create_table "civicrm_job", force: :cascade do |t|
    t.integer  "domain_id",          limit: 4,                       null: false
    t.string   "run_frequency",      limit: 8,     default: "Daily"
    t.datetime "last_run"
    t.datetime "scheduled_run_date"
    t.string   "name",               limit: 255
    t.string   "description",        limit: 255
    t.string   "api_entity",         limit: 255
    t.string   "api_action",         limit: 255
    t.text     "parameters",         limit: 65535
    t.integer  "is_active",          limit: 1
  end

  add_index "civicrm_job", ["domain_id"], name: "FK_civicrm_job_domain_id", using: :btree

  create_table "civicrm_job_log", force: :cascade do |t|
    t.integer  "domain_id",   limit: 4,     null: false
    t.datetime "run_time",                  null: false
    t.integer  "job_id",      limit: 4
    t.string   "name",        limit: 255
    t.string   "command",     limit: 255
    t.string   "description", limit: 255
    t.text     "data",        limit: 65535
  end

  add_index "civicrm_job_log", ["domain_id"], name: "FK_civicrm_job_log_domain_id", using: :btree

  create_table "civicrm_line_item", force: :cascade do |t|
    t.string  "entity_table",          limit: 64,                                         null: false
    t.integer "entity_id",             limit: 4,                                          null: false
    t.integer "contribution_id",       limit: 4
    t.integer "price_field_id",        limit: 4
    t.string  "label",                 limit: 255
    t.decimal "qty",                               precision: 20, scale: 2
    t.decimal "unit_price",                        precision: 20, scale: 2,               null: false
    t.decimal "line_total",                        precision: 20, scale: 2,               null: false
    t.integer "participant_count",     limit: 4
    t.integer "price_field_value_id",  limit: 4
    t.integer "financial_type_id",     limit: 4
    t.decimal "non_deductible_amount",             precision: 20, scale: 2, default: 0.0, null: false
    t.decimal "tax_amount",                        precision: 20, scale: 2
  end

  add_index "civicrm_line_item", ["contribution_id"], name: "FK_civicrm_line_item_contribution_id", using: :btree
  add_index "civicrm_line_item", ["entity_table", "entity_id", "contribution_id", "price_field_value_id", "price_field_id"], name: "UI_line_item_value", unique: true, using: :btree
  add_index "civicrm_line_item", ["entity_table", "entity_id"], name: "index_entity", using: :btree
  add_index "civicrm_line_item", ["financial_type_id"], name: "FK_civicrm_line_item_financial_type_id", using: :btree
  add_index "civicrm_line_item", ["price_field_id"], name: "FK_civicrm_line_item_price_field_id", using: :btree
  add_index "civicrm_line_item", ["price_field_value_id"], name: "FK_civicrm_line_item_price_field_value_id", using: :btree

  create_table "civicrm_loc_block", force: :cascade do |t|
    t.integer "address_id",   limit: 4
    t.integer "email_id",     limit: 4
    t.integer "phone_id",     limit: 4
    t.integer "im_id",        limit: 4
    t.integer "address_2_id", limit: 4
    t.integer "email_2_id",   limit: 4
    t.integer "phone_2_id",   limit: 4
    t.integer "im_2_id",      limit: 4
  end

  add_index "civicrm_loc_block", ["address_2_id"], name: "FK_civicrm_loc_block_address_2_id", using: :btree
  add_index "civicrm_loc_block", ["address_id"], name: "FK_civicrm_loc_block_address_id", using: :btree
  add_index "civicrm_loc_block", ["email_2_id"], name: "FK_civicrm_loc_block_email_2_id", using: :btree
  add_index "civicrm_loc_block", ["email_id"], name: "FK_civicrm_loc_block_email_id", using: :btree
  add_index "civicrm_loc_block", ["im_2_id"], name: "FK_civicrm_loc_block_im_2_id", using: :btree
  add_index "civicrm_loc_block", ["im_id"], name: "FK_civicrm_loc_block_im_id", using: :btree
  add_index "civicrm_loc_block", ["phone_2_id"], name: "FK_civicrm_loc_block_phone_2_id", using: :btree
  add_index "civicrm_loc_block", ["phone_id"], name: "FK_civicrm_loc_block_phone_id", using: :btree

  create_table "civicrm_location_type", force: :cascade do |t|
    t.string  "name",         limit: 64
    t.string  "display_name", limit: 64
    t.string  "vcard_name",   limit: 64
    t.string  "description",  limit: 255
    t.integer "is_reserved",  limit: 1
    t.integer "is_active",    limit: 1
    t.integer "is_default",   limit: 1
  end

  add_index "civicrm_location_type", ["name"], name: "UI_name", unique: true, using: :btree

  create_table "civicrm_log", force: :cascade do |t|
    t.string   "entity_table",  limit: 64,    null: false
    t.integer  "entity_id",     limit: 4,     null: false
    t.text     "data",          limit: 65535
    t.integer  "modified_id",   limit: 4
    t.datetime "modified_date"
  end

  add_index "civicrm_log", ["entity_table", "entity_id"], name: "index_entity", using: :btree
  add_index "civicrm_log", ["modified_id"], name: "FK_civicrm_log_modified_id", using: :btree

  create_table "civicrm_mail_settings", force: :cascade do |t|
    t.integer "domain_id",       limit: 4,   null: false
    t.string  "name",            limit: 255
    t.integer "is_default",      limit: 1
    t.string  "domain",          limit: 255
    t.string  "localpart",       limit: 255
    t.string  "return_path",     limit: 255
    t.string  "protocol",        limit: 255
    t.string  "server",          limit: 255
    t.integer "port",            limit: 4
    t.string  "username",        limit: 255
    t.string  "password",        limit: 255
    t.integer "is_ssl",          limit: 1
    t.string  "source",          limit: 255
    t.string  "activity_status", limit: 255
  end

  add_index "civicrm_mail_settings", ["domain_id"], name: "FK_civicrm_mail_settings_domain_id", using: :btree

  create_table "civicrm_mailing", force: :cascade do |t|
    t.integer  "domain_id",              limit: 4
    t.integer  "header_id",              limit: 4
    t.integer  "footer_id",              limit: 4
    t.integer  "reply_id",               limit: 4
    t.integer  "unsubscribe_id",         limit: 4
    t.integer  "resubscribe_id",         limit: 4
    t.integer  "optout_id",              limit: 4
    t.string   "name",                   limit: 128
    t.string   "from_name",              limit: 128
    t.string   "from_email",             limit: 128
    t.string   "replyto_email",          limit: 128
    t.string   "subject",                limit: 128
    t.text     "body_text",              limit: 4294967295
    t.text     "body_html",              limit: 4294967295
    t.integer  "url_tracking",           limit: 1
    t.integer  "forward_replies",        limit: 1
    t.integer  "auto_responder",         limit: 1
    t.integer  "open_tracking",          limit: 1
    t.integer  "is_completed",           limit: 1
    t.integer  "msg_template_id",        limit: 4
    t.integer  "override_verp",          limit: 1,          default: 0
    t.integer  "created_id",             limit: 4
    t.datetime "created_date"
    t.integer  "scheduled_id",           limit: 4
    t.datetime "scheduled_date"
    t.integer  "approver_id",            limit: 4
    t.datetime "approval_date"
    t.integer  "approval_status_id",     limit: 4
    t.text     "approval_note",          limit: 4294967295
    t.integer  "is_archived",            limit: 1,          default: 0
    t.string   "visibility",             limit: 40,         default: "Public Pages"
    t.integer  "campaign_id",            limit: 4
    t.integer  "dedupe_email",           limit: 1,          default: 0
    t.integer  "sms_provider_id",        limit: 4
    t.string   "hash",                   limit: 16
    t.integer  "location_type_id",       limit: 4
    t.string   "email_selection_method", limit: 20,         default: "automatic"
    t.string   "mailing_type",           limit: 32
    t.string   "language",               limit: 5
    t.string   "template_type",          limit: 64,         default: "traditional",  null: false
    t.text     "template_options",       limit: 4294967295
  end

  add_index "civicrm_mailing", ["approver_id"], name: "FK_civicrm_mailing_approver_id", using: :btree
  add_index "civicrm_mailing", ["campaign_id"], name: "FK_civicrm_mailing_campaign_id", using: :btree
  add_index "civicrm_mailing", ["created_id"], name: "FK_civicrm_mailing_created_id", using: :btree
  add_index "civicrm_mailing", ["domain_id"], name: "FK_civicrm_mailing_domain_id", using: :btree
  add_index "civicrm_mailing", ["footer_id"], name: "FK_civicrm_mailing_footer_id", using: :btree
  add_index "civicrm_mailing", ["hash"], name: "index_hash", using: :btree
  add_index "civicrm_mailing", ["header_id"], name: "FK_civicrm_mailing_header_id", using: :btree
  add_index "civicrm_mailing", ["location_type_id"], name: "FK_civicrm_mailing_location_type_id", using: :btree
  add_index "civicrm_mailing", ["msg_template_id"], name: "FK_civicrm_mailing_msg_template_id", using: :btree
  add_index "civicrm_mailing", ["optout_id"], name: "FK_civicrm_mailing_optout_id", using: :btree
  add_index "civicrm_mailing", ["reply_id"], name: "FK_civicrm_mailing_reply_id", using: :btree
  add_index "civicrm_mailing", ["scheduled_id"], name: "FK_civicrm_mailing_scheduled_id", using: :btree
  add_index "civicrm_mailing", ["sms_provider_id"], name: "FK_civicrm_mailing_sms_provider_id", using: :btree
  add_index "civicrm_mailing", ["unsubscribe_id"], name: "FK_civicrm_mailing_unsubscribe_id", using: :btree

  create_table "civicrm_mailing_abtest", force: :cascade do |t|
    t.string   "name",                 limit: 128
    t.string   "status",               limit: 32
    t.integer  "mailing_id_a",         limit: 4
    t.integer  "mailing_id_b",         limit: 4
    t.integer  "mailing_id_c",         limit: 4
    t.integer  "domain_id",            limit: 4
    t.string   "specific_url",         limit: 255
    t.datetime "declare_winning_time"
    t.integer  "group_percentage",     limit: 4
    t.integer  "created_id",           limit: 4
    t.datetime "created_date"
    t.string   "testing_criteria",     limit: 32
    t.string   "winner_criteria",      limit: 32
  end

  add_index "civicrm_mailing_abtest", ["created_id"], name: "FK_civicrm_mailing_abtest_created_id", using: :btree

  create_table "civicrm_mailing_bounce_pattern", force: :cascade do |t|
    t.integer "bounce_type_id", limit: 4,   null: false
    t.string  "pattern",        limit: 255
  end

  add_index "civicrm_mailing_bounce_pattern", ["bounce_type_id"], name: "FK_civicrm_mailing_bounce_pattern_bounce_type_id", using: :btree

  create_table "civicrm_mailing_bounce_type", force: :cascade do |t|
    t.string  "name",           limit: 24,  null: false
    t.string  "description",    limit: 255
    t.integer "hold_threshold", limit: 4,   null: false
  end

  create_table "civicrm_mailing_component", force: :cascade do |t|
    t.string  "name",           limit: 64
    t.string  "component_type", limit: 12
    t.string  "subject",        limit: 255
    t.text    "body_html",      limit: 65535
    t.text    "body_text",      limit: 65535
    t.integer "is_default",     limit: 1,     default: 0
    t.integer "is_active",      limit: 1
  end

  create_table "civicrm_mailing_event_bounce", force: :cascade do |t|
    t.integer  "event_queue_id", limit: 4,   null: false
    t.integer  "bounce_type_id", limit: 4
    t.string   "bounce_reason",  limit: 255
    t.datetime "time_stamp",                 null: false
  end

  add_index "civicrm_mailing_event_bounce", ["event_queue_id"], name: "FK_civicrm_mailing_event_bounce_event_queue_id", using: :btree

  create_table "civicrm_mailing_event_confirm", force: :cascade do |t|
    t.integer  "event_subscribe_id", limit: 4, null: false
    t.datetime "time_stamp",                   null: false
  end

  add_index "civicrm_mailing_event_confirm", ["event_subscribe_id"], name: "FK_civicrm_mailing_event_confirm_event_subscribe_id", using: :btree

  create_table "civicrm_mailing_event_delivered", force: :cascade do |t|
    t.integer  "event_queue_id", limit: 4, null: false
    t.datetime "time_stamp",               null: false
  end

  add_index "civicrm_mailing_event_delivered", ["event_queue_id"], name: "FK_civicrm_mailing_event_delivered_event_queue_id", using: :btree

  create_table "civicrm_mailing_event_forward", force: :cascade do |t|
    t.integer  "event_queue_id", limit: 4, null: false
    t.integer  "dest_queue_id",  limit: 4
    t.datetime "time_stamp",               null: false
  end

  add_index "civicrm_mailing_event_forward", ["dest_queue_id"], name: "FK_civicrm_mailing_event_forward_dest_queue_id", using: :btree
  add_index "civicrm_mailing_event_forward", ["event_queue_id"], name: "FK_civicrm_mailing_event_forward_event_queue_id", using: :btree

  create_table "civicrm_mailing_event_opened", force: :cascade do |t|
    t.integer  "event_queue_id", limit: 4, null: false
    t.datetime "time_stamp",               null: false
  end

  add_index "civicrm_mailing_event_opened", ["event_queue_id"], name: "FK_civicrm_mailing_event_opened_event_queue_id", using: :btree

  create_table "civicrm_mailing_event_queue", force: :cascade do |t|
    t.integer "job_id",     limit: 4,   null: false
    t.integer "email_id",   limit: 4
    t.integer "contact_id", limit: 4,   null: false
    t.string  "hash",       limit: 255, null: false
    t.integer "phone_id",   limit: 4
  end

  add_index "civicrm_mailing_event_queue", ["contact_id"], name: "FK_civicrm_mailing_event_queue_contact_id", using: :btree
  add_index "civicrm_mailing_event_queue", ["email_id"], name: "FK_civicrm_mailing_event_queue_email_id", using: :btree
  add_index "civicrm_mailing_event_queue", ["hash"], name: "index_hash", using: :btree
  add_index "civicrm_mailing_event_queue", ["job_id"], name: "FK_civicrm_mailing_event_queue_job_id", using: :btree
  add_index "civicrm_mailing_event_queue", ["phone_id"], name: "FK_civicrm_mailing_event_queue_phone_id", using: :btree

  create_table "civicrm_mailing_event_reply", force: :cascade do |t|
    t.integer  "event_queue_id", limit: 4, null: false
    t.datetime "time_stamp",               null: false
  end

  add_index "civicrm_mailing_event_reply", ["event_queue_id"], name: "FK_civicrm_mailing_event_reply_event_queue_id", using: :btree

  create_table "civicrm_mailing_event_subscribe", force: :cascade do |t|
    t.integer  "group_id",   limit: 4,   null: false
    t.integer  "contact_id", limit: 4,   null: false
    t.string   "hash",       limit: 255, null: false
    t.datetime "time_stamp",             null: false
  end

  add_index "civicrm_mailing_event_subscribe", ["contact_id"], name: "FK_civicrm_mailing_event_subscribe_contact_id", using: :btree
  add_index "civicrm_mailing_event_subscribe", ["group_id"], name: "FK_civicrm_mailing_event_subscribe_group_id", using: :btree

  create_table "civicrm_mailing_event_trackable_url_open", force: :cascade do |t|
    t.integer  "event_queue_id",   limit: 4, null: false
    t.integer  "trackable_url_id", limit: 4, null: false
    t.datetime "time_stamp",                 null: false
  end

  add_index "civicrm_mailing_event_trackable_url_open", ["event_queue_id"], name: "FK_civicrm_mailing_event_trackable_url_open_event_queue_id", using: :btree
  add_index "civicrm_mailing_event_trackable_url_open", ["trackable_url_id"], name: "FK_civicrm_mailing_event_trackable_url_open_trackable_url_id", using: :btree

  create_table "civicrm_mailing_event_unsubscribe", force: :cascade do |t|
    t.integer  "event_queue_id",  limit: 4, null: false
    t.integer  "org_unsubscribe", limit: 1, null: false
    t.datetime "time_stamp",                null: false
  end

  add_index "civicrm_mailing_event_unsubscribe", ["event_queue_id"], name: "FK_civicrm_mailing_event_unsubscribe_event_queue_id", using: :btree

  create_table "civicrm_mailing_group", force: :cascade do |t|
    t.integer "mailing_id",   limit: 4,     null: false
    t.string  "group_type",   limit: 8
    t.string  "entity_table", limit: 64,    null: false
    t.integer "entity_id",    limit: 4,     null: false
    t.integer "search_id",    limit: 4
    t.text    "search_args",  limit: 65535
  end

  add_index "civicrm_mailing_group", ["mailing_id"], name: "FK_civicrm_mailing_group_mailing_id", using: :btree

  create_table "civicrm_mailing_job", force: :cascade do |t|
    t.integer  "mailing_id",     limit: 4,               null: false
    t.datetime "scheduled_date"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "status",         limit: 12
    t.integer  "is_test",        limit: 1,   default: 0
    t.string   "job_type",       limit: 255
    t.integer  "parent_id",      limit: 4
    t.integer  "job_offset",     limit: 4,   default: 0
    t.integer  "job_limit",      limit: 4,   default: 0
  end

  add_index "civicrm_mailing_job", ["mailing_id"], name: "FK_civicrm_mailing_job_mailing_id", using: :btree
  add_index "civicrm_mailing_job", ["parent_id"], name: "FK_civicrm_mailing_job_parent_id", using: :btree

  create_table "civicrm_mailing_recipients", force: :cascade do |t|
    t.integer "mailing_id", limit: 4, null: false
    t.integer "contact_id", limit: 4, null: false
    t.integer "email_id",   limit: 4
    t.integer "phone_id",   limit: 4
  end

  add_index "civicrm_mailing_recipients", ["contact_id"], name: "FK_civicrm_mailing_recipients_contact_id", using: :btree
  add_index "civicrm_mailing_recipients", ["email_id"], name: "FK_civicrm_mailing_recipients_email_id", using: :btree
  add_index "civicrm_mailing_recipients", ["mailing_id"], name: "FK_civicrm_mailing_recipients_mailing_id", using: :btree
  add_index "civicrm_mailing_recipients", ["phone_id"], name: "FK_civicrm_mailing_recipients_phone_id", using: :btree

  create_table "civicrm_mailing_spool", force: :cascade do |t|
    t.integer  "job_id",          limit: 4,     null: false
    t.text     "recipient_email", limit: 65535
    t.text     "headers",         limit: 65535
    t.text     "body",            limit: 65535
    t.datetime "added_at"
    t.datetime "removed_at"
  end

  add_index "civicrm_mailing_spool", ["job_id"], name: "FK_civicrm_mailing_spool_job_id", using: :btree

  create_table "civicrm_mailing_trackable_url", force: :cascade do |t|
    t.text    "url",        limit: 65535, null: false
    t.integer "mailing_id", limit: 4,     null: false
  end

  add_index "civicrm_mailing_trackable_url", ["mailing_id"], name: "FK_civicrm_mailing_trackable_url_mailing_id", using: :btree

  create_table "civicrm_managed", force: :cascade do |t|
    t.string  "module",      limit: 127, null: false
    t.string  "name",        limit: 127
    t.string  "entity_type", limit: 64,  null: false
    t.integer "entity_id",   limit: 4,   null: false
    t.string  "cleanup",     limit: 32
  end

  add_index "civicrm_managed", ["entity_type", "entity_id"], name: "UI_managed_entity", using: :btree
  add_index "civicrm_managed", ["module", "name"], name: "UI_managed_module_name", using: :btree

  create_table "civicrm_mapping", force: :cascade do |t|
    t.string  "name",            limit: 64
    t.string  "description",     limit: 255
    t.integer "mapping_type_id", limit: 4
  end

  add_index "civicrm_mapping", ["name"], name: "UI_name", using: :btree

  create_table "civicrm_mapping_field", force: :cascade do |t|
    t.integer "mapping_id",             limit: 4,               null: false
    t.string  "name",                   limit: 255
    t.string  "contact_type",           limit: 64
    t.integer "column_number",          limit: 4,               null: false
    t.integer "location_type_id",       limit: 4
    t.integer "phone_type_id",          limit: 4
    t.integer "im_provider_id",         limit: 4
    t.integer "website_type_id",        limit: 4
    t.integer "relationship_type_id",   limit: 4
    t.string  "relationship_direction", limit: 6
    t.integer "grouping",               limit: 4,   default: 1
    t.string  "operator",               limit: 16
    t.string  "value",                  limit: 255
  end

  add_index "civicrm_mapping_field", ["location_type_id"], name: "FK_civicrm_mapping_field_location_type_id", using: :btree
  add_index "civicrm_mapping_field", ["mapping_id"], name: "FK_civicrm_mapping_field_mapping_id", using: :btree
  add_index "civicrm_mapping_field", ["relationship_type_id"], name: "FK_civicrm_mapping_field_relationship_type_id", using: :btree

  create_table "civicrm_membership", force: :cascade do |t|
    t.integer "contact_id",            limit: 4,               null: false
    t.integer "membership_type_id",    limit: 4,               null: false
    t.date    "join_date"
    t.date    "start_date"
    t.date    "end_date"
    t.string  "source",                limit: 128
    t.integer "status_id",             limit: 4,               null: false
    t.integer "is_override",           limit: 1
    t.integer "owner_membership_id",   limit: 4
    t.integer "max_related",           limit: 4
    t.integer "is_test",               limit: 1,   default: 0
    t.integer "is_pay_later",          limit: 1,   default: 0
    t.integer "contribution_recur_id", limit: 4
    t.integer "campaign_id",           limit: 4
  end

  add_index "civicrm_membership", ["campaign_id"], name: "FK_civicrm_membership_campaign_id", using: :btree
  add_index "civicrm_membership", ["contact_id"], name: "FK_civicrm_membership_contact_id", using: :btree
  add_index "civicrm_membership", ["contribution_recur_id"], name: "FK_civicrm_membership_contribution_recur_id", using: :btree
  add_index "civicrm_membership", ["membership_type_id"], name: "FK_civicrm_membership_membership_type_id", using: :btree
  add_index "civicrm_membership", ["owner_membership_id"], name: "index_owner_membership_id", using: :btree
  add_index "civicrm_membership", ["status_id"], name: "FK_civicrm_membership_status_id", using: :btree

  create_table "civicrm_membership_block", force: :cascade do |t|
    t.string  "entity_table",            limit: 64
    t.integer "entity_id",               limit: 4,                 null: false
    t.string  "membership_types",        limit: 1024
    t.integer "membership_type_default", limit: 4
    t.integer "display_min_fee",         limit: 1,     default: 1
    t.integer "is_separate_payment",     limit: 1,     default: 1
    t.string  "new_title",               limit: 255
    t.text    "new_text",                limit: 65535
    t.string  "renewal_title",           limit: 255
    t.text    "renewal_text",            limit: 65535
    t.integer "is_required",             limit: 1,     default: 0
    t.integer "is_active",               limit: 1,     default: 1
  end

  add_index "civicrm_membership_block", ["entity_id"], name: "FK_civicrm_membership_block_entity_id", using: :btree
  add_index "civicrm_membership_block", ["membership_type_default"], name: "FK_civicrm_membership_block_membership_type_default", using: :btree

  create_table "civicrm_membership_log", force: :cascade do |t|
    t.integer "membership_id",      limit: 4, null: false
    t.integer "status_id",          limit: 4, null: false
    t.date    "start_date"
    t.date    "end_date"
    t.integer "modified_id",        limit: 4
    t.date    "modified_date"
    t.integer "membership_type_id", limit: 4
    t.integer "max_related",        limit: 4
  end

  add_index "civicrm_membership_log", ["membership_id"], name: "FK_civicrm_membership_log_membership_id", using: :btree
  add_index "civicrm_membership_log", ["membership_type_id"], name: "FK_civicrm_membership_log_membership_type_id", using: :btree
  add_index "civicrm_membership_log", ["modified_id"], name: "FK_civicrm_membership_log_modified_id", using: :btree
  add_index "civicrm_membership_log", ["status_id"], name: "FK_civicrm_membership_log_status_id", using: :btree

  create_table "civicrm_membership_payment", force: :cascade do |t|
    t.integer "membership_id",   limit: 4, null: false
    t.integer "contribution_id", limit: 4
  end

  add_index "civicrm_membership_payment", ["contribution_id", "membership_id"], name: "UI_contribution_membership", unique: true, using: :btree
  add_index "civicrm_membership_payment", ["membership_id"], name: "FK_civicrm_membership_payment_membership_id", using: :btree

  create_table "civicrm_membership_status", force: :cascade do |t|
    t.string  "name",                        limit: 128
    t.string  "label",                       limit: 128
    t.string  "start_event",                 limit: 12
    t.string  "start_event_adjust_unit",     limit: 8
    t.integer "start_event_adjust_interval", limit: 4
    t.string  "end_event",                   limit: 12
    t.string  "end_event_adjust_unit",       limit: 8
    t.integer "end_event_adjust_interval",   limit: 4
    t.integer "is_current_member",           limit: 1
    t.integer "is_admin",                    limit: 1
    t.integer "weight",                      limit: 4
    t.integer "is_default",                  limit: 1
    t.integer "is_active",                   limit: 1,   default: 1
    t.integer "is_reserved",                 limit: 1,   default: 0
  end

  create_table "civicrm_membership_type", force: :cascade do |t|
    t.integer "domain_id",                 limit: 4,                                          null: false
    t.string  "name",                      limit: 128
    t.string  "description",               limit: 255
    t.integer "member_of_contact_id",      limit: 4,                                          null: false
    t.integer "financial_type_id",         limit: 4,                                          null: false
    t.decimal "minimum_fee",                           precision: 20, scale: 2, default: 0.0
    t.string  "duration_unit",             limit: 8
    t.integer "duration_interval",         limit: 4
    t.string  "period_type",               limit: 8
    t.integer "fixed_period_start_day",    limit: 4
    t.integer "fixed_period_rollover_day", limit: 4
    t.string  "relationship_type_id",      limit: 64
    t.string  "relationship_direction",    limit: 128
    t.integer "max_related",               limit: 4
    t.string  "visibility",                limit: 64
    t.integer "weight",                    limit: 4
    t.string  "receipt_text_signup",       limit: 255
    t.string  "receipt_text_renewal",      limit: 255
    t.integer "auto_renew",                limit: 1,                            default: 0
    t.integer "is_active",                 limit: 1,                            default: 1
  end

  add_index "civicrm_membership_type", ["domain_id"], name: "FK_civicrm_membership_type_domain_id", using: :btree
  add_index "civicrm_membership_type", ["financial_type_id"], name: "FK_civicrm_membership_type_financial_type_id", using: :btree
  add_index "civicrm_membership_type", ["member_of_contact_id"], name: "FK_civicrm_membership_type_member_of_contact_id", using: :btree
  add_index "civicrm_membership_type", ["relationship_type_id"], name: "index_relationship_type_id", using: :btree

  create_table "civicrm_menu", force: :cascade do |t|
    t.integer "domain_id",        limit: 4,                 null: false
    t.string  "path",             limit: 255
    t.text    "path_arguments",   limit: 65535
    t.string  "title",            limit: 255
    t.string  "access_callback",  limit: 255
    t.text    "access_arguments", limit: 65535
    t.string  "page_callback",    limit: 255
    t.text    "page_arguments",   limit: 65535
    t.text    "breadcrumb",       limit: 65535
    t.string  "return_url",       limit: 255
    t.string  "return_url_args",  limit: 255
    t.integer "component_id",     limit: 4
    t.integer "is_active",        limit: 1
    t.integer "is_public",        limit: 1
    t.integer "is_exposed",       limit: 1
    t.integer "is_ssl",           limit: 1
    t.integer "weight",           limit: 4,     default: 1, null: false
    t.integer "type",             limit: 4,     default: 1, null: false
    t.integer "page_type",        limit: 4,     default: 1, null: false
    t.integer "skipBreadcrumb",   limit: 1
  end

  add_index "civicrm_menu", ["component_id"], name: "FK_civicrm_menu_component_id", using: :btree
  add_index "civicrm_menu", ["domain_id"], name: "FK_civicrm_menu_domain_id", using: :btree
  add_index "civicrm_menu", ["path", "domain_id"], name: "UI_path_domain_id", unique: true, using: :btree

  create_table "civicrm_msg_template", force: :cascade do |t|
    t.string  "msg_title",     limit: 255
    t.text    "msg_subject",   limit: 65535
    t.text    "msg_text",      limit: 4294967295
    t.text    "msg_html",      limit: 4294967295
    t.integer "is_active",     limit: 1,          default: 1
    t.integer "workflow_id",   limit: 4
    t.integer "is_default",    limit: 1,          default: 1
    t.integer "is_reserved",   limit: 1
    t.integer "is_sms",        limit: 1,          default: 0
    t.integer "pdf_format_id", limit: 4
  end

  create_table "civicrm_navigation", force: :cascade do |t|
    t.integer "domain_id",           limit: 4,   null: false
    t.string  "label",               limit: 255
    t.string  "name",                limit: 255
    t.string  "url",                 limit: 255
    t.string  "permission",          limit: 255
    t.string  "permission_operator", limit: 3
    t.integer "parent_id",           limit: 4
    t.integer "is_active",           limit: 1
    t.integer "has_separator",       limit: 1
    t.integer "weight",              limit: 4
  end

  add_index "civicrm_navigation", ["domain_id"], name: "FK_civicrm_navigation_domain_id", using: :btree
  add_index "civicrm_navigation", ["parent_id"], name: "FK_civicrm_navigation_parent_id", using: :btree

  create_table "civicrm_note", force: :cascade do |t|
    t.string  "entity_table",  limit: 64,    null: false
    t.integer "entity_id",     limit: 4,     null: false
    t.text    "note",          limit: 65535
    t.integer "contact_id",    limit: 4
    t.date    "modified_date"
    t.string  "subject",       limit: 255
    t.string  "privacy",       limit: 255
  end

  add_index "civicrm_note", ["contact_id"], name: "FK_civicrm_note_contact_id", using: :btree
  add_index "civicrm_note", ["entity_table", "entity_id"], name: "index_entity", using: :btree

  create_table "civicrm_openid", force: :cascade do |t|
    t.integer "contact_id",       limit: 4
    t.integer "location_type_id", limit: 4
    t.string  "openid",           limit: 255
    t.integer "allowed_to_login", limit: 1,   default: 0, null: false
    t.integer "is_primary",       limit: 1,   default: 0
  end

  add_index "civicrm_openid", ["contact_id"], name: "FK_civicrm_openid_contact_id", using: :btree
  add_index "civicrm_openid", ["location_type_id"], name: "index_location_type", using: :btree
  add_index "civicrm_openid", ["openid"], name: "UI_openid", unique: true, using: :btree

  create_table "civicrm_option_group", force: :cascade do |t|
    t.string  "name",        limit: 64,              null: false
    t.string  "title",       limit: 255
    t.string  "description", limit: 255
    t.integer "is_reserved", limit: 1,   default: 1
    t.integer "is_active",   limit: 1
    t.integer "is_locked",   limit: 1
    t.string  "data_type",   limit: 128
  end

  add_index "civicrm_option_group", ["name"], name: "UI_name", unique: true, using: :btree

  create_table "civicrm_option_value", force: :cascade do |t|
    t.integer "option_group_id", limit: 4,                 null: false
    t.string  "label",           limit: 512
    t.string  "value",           limit: 512,               null: false
    t.string  "name",            limit: 255
    t.string  "grouping",        limit: 255
    t.integer "filter",          limit: 4
    t.integer "is_default",      limit: 1,     default: 0
    t.integer "weight",          limit: 4,                 null: false
    t.text    "description",     limit: 65535
    t.integer "is_optgroup",     limit: 1,     default: 0
    t.integer "is_reserved",     limit: 1,     default: 0
    t.integer "is_active",       limit: 1,     default: 1
    t.integer "component_id",    limit: 4
    t.integer "domain_id",       limit: 4
    t.integer "visibility_id",   limit: 4
    t.string  "icon",            limit: 255
    t.string  "color",           limit: 255
  end

  add_index "civicrm_option_value", ["component_id"], name: "FK_civicrm_option_value_component_id", using: :btree
  add_index "civicrm_option_value", ["domain_id"], name: "FK_civicrm_option_value_domain_id", using: :btree
  add_index "civicrm_option_value", ["name", "option_group_id"], name: "index_option_group_id_name", length: {"name"=>128, "option_group_id"=>nil}, using: :btree
  add_index "civicrm_option_value", ["option_group_id"], name: "FK_civicrm_option_value_option_group_id", using: :btree
  add_index "civicrm_option_value", ["value", "option_group_id"], name: "index_option_group_id_value", length: {"value"=>128, "option_group_id"=>nil}, using: :btree

  create_table "civicrm_participant", force: :cascade do |t|
    t.integer  "contact_id",                limit: 4,                                          null: false
    t.integer  "event_id",                  limit: 4,                                          null: false
    t.integer  "status_id",                 limit: 4,                              default: 1, null: false
    t.string   "role_id",                   limit: 128
    t.datetime "register_date"
    t.string   "source",                    limit: 128
    t.text     "fee_level",                 limit: 65535
    t.integer  "is_test",                   limit: 1,                              default: 0
    t.integer  "is_pay_later",              limit: 1,                              default: 0
    t.decimal  "fee_amount",                              precision: 20, scale: 2
    t.integer  "registered_by_id",          limit: 4
    t.integer  "discount_id",               limit: 4
    t.string   "fee_currency",              limit: 3
    t.integer  "campaign_id",               limit: 4
    t.integer  "discount_amount",           limit: 4
    t.integer  "cart_id",                   limit: 4
    t.integer  "must_wait",                 limit: 4
    t.integer  "transferred_to_contact_id", limit: 4
  end

  add_index "civicrm_participant", ["campaign_id"], name: "FK_civicrm_participant_campaign_id", using: :btree
  add_index "civicrm_participant", ["cart_id"], name: "FK_civicrm_participant_cart_id", using: :btree
  add_index "civicrm_participant", ["contact_id"], name: "FK_civicrm_participant_contact_id", using: :btree
  add_index "civicrm_participant", ["discount_id"], name: "FK_civicrm_participant_discount_id", using: :btree
  add_index "civicrm_participant", ["event_id"], name: "FK_civicrm_participant_event_id", using: :btree
  add_index "civicrm_participant", ["registered_by_id"], name: "FK_civicrm_participant_registered_by_id", using: :btree
  add_index "civicrm_participant", ["role_id"], name: "index_role_id", using: :btree
  add_index "civicrm_participant", ["status_id"], name: "index_status_id", using: :btree
  add_index "civicrm_participant", ["transferred_to_contact_id"], name: "FK_civicrm_participant_transferred_to_contact_id", using: :btree

  create_table "civicrm_participant_payment", force: :cascade do |t|
    t.integer "participant_id",  limit: 4, null: false
    t.integer "contribution_id", limit: 4, null: false
  end

  add_index "civicrm_participant_payment", ["contribution_id", "participant_id"], name: "UI_contribution_participant", unique: true, using: :btree
  add_index "civicrm_participant_payment", ["participant_id"], name: "FK_civicrm_participant_payment_participant_id", using: :btree

  create_table "civicrm_participant_status_type", force: :cascade do |t|
    t.string  "name",          limit: 64
    t.string  "label",         limit: 255
    t.string  "class",         limit: 8
    t.integer "is_reserved",   limit: 1
    t.integer "is_active",     limit: 1,   default: 1
    t.integer "is_counted",    limit: 1
    t.integer "weight",        limit: 4,               null: false
    t.integer "visibility_id", limit: 4
  end

  create_table "civicrm_payment_processor", force: :cascade do |t|
    t.integer "domain_id",                 limit: 4,                 null: false
    t.string  "name",                      limit: 64
    t.string  "description",               limit: 255
    t.integer "payment_processor_type_id", limit: 4
    t.integer "is_active",                 limit: 1
    t.integer "is_default",                limit: 1
    t.integer "is_test",                   limit: 1
    t.string  "user_name",                 limit: 255
    t.string  "password",                  limit: 255
    t.text    "signature",                 limit: 65535
    t.string  "url_site",                  limit: 255
    t.string  "url_api",                   limit: 255
    t.string  "url_recur",                 limit: 255
    t.string  "url_button",                limit: 255
    t.string  "subject",                   limit: 255
    t.string  "class_name",                limit: 255
    t.integer "billing_mode",              limit: 4,                 null: false
    t.integer "is_recur",                  limit: 1
    t.integer "payment_type",              limit: 4,     default: 1
    t.integer "payment_instrument_id",     limit: 4,     default: 1
    t.text    "accepted_credit_cards",     limit: 65535
  end

  add_index "civicrm_payment_processor", ["domain_id"], name: "FK_civicrm_payment_processor_domain_id", using: :btree
  add_index "civicrm_payment_processor", ["name", "is_test", "domain_id"], name: "UI_name_test_domain_id", unique: true, using: :btree
  add_index "civicrm_payment_processor", ["payment_processor_type_id"], name: "FK_civicrm_payment_processor_payment_processor_type_id", using: :btree

  create_table "civicrm_payment_processor_type", force: :cascade do |t|
    t.string  "name",                    limit: 64
    t.string  "title",                   limit: 127
    t.string  "description",             limit: 255
    t.integer "is_active",               limit: 1
    t.integer "is_default",              limit: 1
    t.string  "user_name_label",         limit: 255
    t.string  "password_label",          limit: 255
    t.string  "signature_label",         limit: 255
    t.string  "subject_label",           limit: 255
    t.string  "class_name",              limit: 255
    t.string  "url_site_default",        limit: 255
    t.string  "url_api_default",         limit: 255
    t.string  "url_recur_default",       limit: 255
    t.string  "url_button_default",      limit: 255
    t.string  "url_site_test_default",   limit: 255
    t.string  "url_api_test_default",    limit: 255
    t.string  "url_recur_test_default",  limit: 255
    t.string  "url_button_test_default", limit: 255
    t.integer "billing_mode",            limit: 4,               null: false
    t.integer "is_recur",                limit: 1
    t.integer "payment_type",            limit: 4,   default: 1
    t.integer "payment_instrument_id",   limit: 4,   default: 1
  end

  add_index "civicrm_payment_processor_type", ["name"], name: "UI_name", unique: true, using: :btree

  create_table "civicrm_payment_token", force: :cascade do |t|
    t.integer  "contact_id",            limit: 4,   null: false
    t.integer  "payment_processor_id",  limit: 4,   null: false
    t.string   "token",                 limit: 255, null: false
    t.datetime "created_date",                      null: false
    t.integer  "created_id",            limit: 4
    t.datetime "expiry_date"
    t.string   "email",                 limit: 255
    t.string   "billing_first_name",    limit: 255
    t.string   "billing_middle_name",   limit: 255
    t.string   "billing_last_name",     limit: 255
    t.string   "masked_account_number", limit: 255
    t.string   "ip_address",            limit: 255
  end

  add_index "civicrm_payment_token", ["contact_id"], name: "FK_civicrm_payment_token_contact_id", using: :btree
  add_index "civicrm_payment_token", ["created_id"], name: "FK_civicrm_payment_token_created_id", using: :btree
  add_index "civicrm_payment_token", ["payment_processor_id"], name: "FK_civicrm_payment_token_payment_processor_id", using: :btree

  create_table "civicrm_pcp", force: :cascade do |t|
    t.integer "contact_id",       limit: 4,                                                     null: false
    t.integer "status_id",        limit: 4,                                                     null: false
    t.string  "title",            limit: 255
    t.text    "intro_text",       limit: 65535
    t.text    "page_text",        limit: 65535
    t.string  "donate_link_text", limit: 255
    t.integer "page_id",          limit: 4,                                                     null: false
    t.string  "page_type",        limit: 64,                             default: "contribute"
    t.integer "pcp_block_id",     limit: 4,                                                     null: false
    t.integer "is_thermometer",   limit: 4,                              default: 0
    t.integer "is_honor_roll",    limit: 4,                              default: 0
    t.decimal "goal_amount",                    precision: 20, scale: 2
    t.string  "currency",         limit: 3
    t.integer "is_active",        limit: 1,                              default: 0
    t.integer "is_notify",        limit: 4,                              default: 0,            null: false
  end

  add_index "civicrm_pcp", ["contact_id"], name: "FK_civicrm_pcp_contact_id", using: :btree

  create_table "civicrm_pcp_block", force: :cascade do |t|
    t.string  "entity_table",          limit: 64
    t.integer "entity_id",             limit: 4,                          null: false
    t.string  "target_entity_type",    limit: 255, default: "contribute", null: false
    t.integer "target_entity_id",      limit: 4,                          null: false
    t.integer "supporter_profile_id",  limit: 4
    t.integer "is_approval_needed",    limit: 1
    t.integer "is_tellfriend_enabled", limit: 1
    t.integer "tellfriend_limit",      limit: 4
    t.string  "link_text",             limit: 255
    t.integer "is_active",             limit: 1,   default: 1
    t.string  "notify_email",          limit: 255
    t.integer "owner_notify_id",       limit: 4
  end

  add_index "civicrm_pcp_block", ["supporter_profile_id"], name: "FK_civicrm_pcp_block_supporter_profile_id", using: :btree

  create_table "civicrm_persistent", force: :cascade do |t|
    t.string  "context",   limit: 255,                    null: false
    t.string  "name",      limit: 255,                    null: false
    t.text    "data",      limit: 4294967295
    t.integer "is_config", limit: 1,          default: 0, null: false
  end

  create_table "civicrm_phone", force: :cascade do |t|
    t.integer "contact_id",         limit: 4
    t.integer "location_type_id",   limit: 4
    t.integer "is_primary",         limit: 1,  default: 0
    t.integer "is_billing",         limit: 1,  default: 0
    t.integer "mobile_provider_id", limit: 4
    t.string  "phone",              limit: 32
    t.string  "phone_ext",          limit: 16
    t.string  "phone_numeric",      limit: 32
    t.integer "phone_type_id",      limit: 4
  end

  add_index "civicrm_phone", ["contact_id"], name: "FK_civicrm_phone_contact_id", using: :btree
  add_index "civicrm_phone", ["is_billing"], name: "index_is_billing", using: :btree
  add_index "civicrm_phone", ["is_primary"], name: "index_is_primary", using: :btree
  add_index "civicrm_phone", ["location_type_id"], name: "index_location_type", using: :btree
  add_index "civicrm_phone", ["mobile_provider_id"], name: "UI_mobile_provider_id", using: :btree
  add_index "civicrm_phone", ["phone"], name: "dedupe_index_phone", using: :btree
  add_index "civicrm_phone", ["phone_numeric"], name: "index_phone_numeric", using: :btree

  create_table "civicrm_pledge", force: :cascade do |t|
    t.integer  "contact_id",                  limit: 4,                                            null: false
    t.integer  "financial_type_id",           limit: 4
    t.integer  "contribution_page_id",        limit: 4
    t.decimal  "amount",                                precision: 20, scale: 2,                   null: false
    t.decimal  "original_installment_amount",           precision: 20, scale: 2,                   null: false
    t.string   "currency",                    limit: 3
    t.string   "frequency_unit",              limit: 8,                          default: "month"
    t.integer  "frequency_interval",          limit: 4,                          default: 1,       null: false
    t.integer  "frequency_day",               limit: 4,                          default: 3,       null: false
    t.integer  "installments",                limit: 4,                          default: 1
    t.datetime "start_date",                                                                       null: false
    t.datetime "create_date",                                                                      null: false
    t.datetime "acknowledge_date"
    t.datetime "modified_date"
    t.datetime "cancel_date"
    t.datetime "end_date"
    t.integer  "max_reminders",               limit: 4,                          default: 1
    t.integer  "initial_reminder_day",        limit: 4,                          default: 5
    t.integer  "additional_reminder_day",     limit: 4,                          default: 5
    t.integer  "status_id",                   limit: 4
    t.integer  "is_test",                     limit: 1,                          default: 0
    t.integer  "campaign_id",                 limit: 4
  end

  add_index "civicrm_pledge", ["campaign_id"], name: "FK_civicrm_pledge_campaign_id", using: :btree
  add_index "civicrm_pledge", ["contact_id"], name: "FK_civicrm_pledge_contact_id", using: :btree
  add_index "civicrm_pledge", ["contribution_page_id"], name: "FK_civicrm_pledge_contribution_page_id", using: :btree
  add_index "civicrm_pledge", ["financial_type_id"], name: "FK_civicrm_pledge_financial_type_id", using: :btree
  add_index "civicrm_pledge", ["status_id"], name: "index_status", using: :btree

  create_table "civicrm_pledge_block", force: :cascade do |t|
    t.string  "entity_table",                  limit: 64
    t.integer "entity_id",                     limit: 4,               null: false
    t.string  "pledge_frequency_unit",         limit: 128
    t.integer "is_pledge_interval",            limit: 1,   default: 0
    t.integer "max_reminders",                 limit: 4,   default: 1
    t.integer "initial_reminder_day",          limit: 4,   default: 5
    t.integer "additional_reminder_day",       limit: 4,   default: 5
    t.string  "pledge_start_date",             limit: 64
    t.integer "is_pledge_start_date_visible",  limit: 1,   default: 0, null: false
    t.integer "is_pledge_start_date_editable", limit: 1,   default: 0, null: false
  end

  add_index "civicrm_pledge_block", ["entity_table", "entity_id"], name: "index_entity", using: :btree

  create_table "civicrm_pledge_payment", force: :cascade do |t|
    t.integer  "pledge_id",        limit: 4,                                      null: false
    t.integer  "contribution_id",  limit: 4
    t.decimal  "scheduled_amount",           precision: 20, scale: 2,             null: false
    t.decimal  "actual_amount",              precision: 20, scale: 2
    t.string   "currency",         limit: 3
    t.datetime "scheduled_date",                                                  null: false
    t.datetime "reminder_date"
    t.integer  "reminder_count",   limit: 4,                          default: 0
    t.integer  "status_id",        limit: 4
  end

  add_index "civicrm_pledge_payment", ["contribution_id", "pledge_id"], name: "index_contribution_pledge", using: :btree
  add_index "civicrm_pledge_payment", ["pledge_id"], name: "FK_civicrm_pledge_payment_pledge_id", using: :btree
  add_index "civicrm_pledge_payment", ["status_id"], name: "index_status", using: :btree

  create_table "civicrm_preferences_date", force: :cascade do |t|
    t.string  "name",        limit: 64,  null: false
    t.string  "description", limit: 255
    t.integer "start",       limit: 4,   null: false
    t.integer "end",         limit: 4,   null: false
    t.string  "date_format", limit: 64
    t.string  "time_format", limit: 64
  end

  add_index "civicrm_preferences_date", ["name"], name: "index_name", using: :btree

  create_table "civicrm_premiums", force: :cascade do |t|
    t.string  "entity_table",                      limit: 64,                null: false
    t.integer "entity_id",                         limit: 4,                 null: false
    t.integer "premiums_active",                   limit: 1,     default: 0, null: false
    t.string  "premiums_intro_title",              limit: 255
    t.text    "premiums_intro_text",               limit: 65535
    t.string  "premiums_contact_email",            limit: 100
    t.string  "premiums_contact_phone",            limit: 50
    t.integer "premiums_display_min_contribution", limit: 1,                 null: false
    t.string  "premiums_nothankyou_label",         limit: 255
    t.integer "premiums_nothankyou_position",      limit: 4,     default: 1
  end

  create_table "civicrm_premiums_product", force: :cascade do |t|
    t.integer "premiums_id",       limit: 4, null: false
    t.integer "product_id",        limit: 4, null: false
    t.integer "weight",            limit: 4, null: false
    t.integer "financial_type_id", limit: 4
  end

  add_index "civicrm_premiums_product", ["financial_type_id"], name: "FK_civicrm_premiums_product_financial_type_id", using: :btree
  add_index "civicrm_premiums_product", ["premiums_id"], name: "FK_civicrm_premiums_product_premiums_id", using: :btree
  add_index "civicrm_premiums_product", ["product_id"], name: "FK_civicrm_premiums_product_product_id", using: :btree

  create_table "civicrm_prevnext_cache", force: :cascade do |t|
    t.string  "entity_table", limit: 64
    t.integer "entity_id1",   limit: 4,                      null: false
    t.integer "entity_id2",   limit: 4,                      null: false
    t.string  "cacheKey",     limit: 255
    t.text    "data",         limit: 4294967295
    t.integer "is_selected",  limit: 1,          default: 0
  end

  add_index "civicrm_prevnext_cache", ["cacheKey", "entity_id1", "entity_id2", "entity_table", "is_selected"], name: "index_all", using: :btree

  create_table "civicrm_price_field", force: :cascade do |t|
    t.integer  "price_set_id",       limit: 4,                 null: false
    t.string   "name",               limit: 255,               null: false
    t.string   "label",              limit: 255,               null: false
    t.string   "html_type",          limit: 12,                null: false
    t.integer  "is_enter_qty",       limit: 1,     default: 0
    t.text     "help_pre",           limit: 65535
    t.text     "help_post",          limit: 65535
    t.integer  "weight",             limit: 4,     default: 1
    t.integer  "is_display_amounts", limit: 1,     default: 1
    t.integer  "options_per_line",   limit: 4,     default: 1
    t.integer  "is_active",          limit: 1,     default: 1
    t.integer  "is_required",        limit: 1,     default: 1
    t.datetime "active_on"
    t.datetime "expire_on"
    t.string   "javascript",         limit: 255
    t.integer  "visibility_id",      limit: 4,     default: 1
  end

  add_index "civicrm_price_field", ["name"], name: "index_name", using: :btree
  add_index "civicrm_price_field", ["price_set_id"], name: "FK_civicrm_price_field_price_set_id", using: :btree

  create_table "civicrm_price_field_value", force: :cascade do |t|
    t.integer "price_field_id",        limit: 4,                                            null: false
    t.string  "name",                  limit: 255
    t.string  "label",                 limit: 255
    t.text    "description",           limit: 65535
    t.string  "amount",                limit: 512,                                          null: false
    t.integer "count",                 limit: 4
    t.integer "max_value",             limit: 4
    t.integer "weight",                limit: 4,                              default: 1
    t.integer "membership_type_id",    limit: 4
    t.integer "membership_num_terms",  limit: 4
    t.integer "is_default",            limit: 1,                              default: 0
    t.integer "is_active",             limit: 1,                              default: 1
    t.integer "financial_type_id",     limit: 4
    t.decimal "non_deductible_amount",               precision: 20, scale: 2, default: 0.0, null: false
    t.text    "help_pre",              limit: 65535
    t.text    "help_post",             limit: 65535
  end

  add_index "civicrm_price_field_value", ["financial_type_id"], name: "FK_civicrm_price_field_value_financial_type_id", using: :btree
  add_index "civicrm_price_field_value", ["membership_type_id"], name: "FK_civicrm_price_field_value_membership_type_id", using: :btree
  add_index "civicrm_price_field_value", ["price_field_id"], name: "FK_civicrm_price_field_value_price_field_id", using: :btree

  create_table "civicrm_price_set", force: :cascade do |t|
    t.integer "domain_id",         limit: 4
    t.string  "name",              limit: 255,               null: false
    t.string  "title",             limit: 255,               null: false
    t.integer "is_active",         limit: 1,     default: 1
    t.text    "help_pre",          limit: 65535
    t.text    "help_post",         limit: 65535
    t.string  "javascript",        limit: 64
    t.string  "extends",           limit: 255,               null: false
    t.integer "financial_type_id", limit: 4
    t.integer "is_quick_config",   limit: 1,     default: 0
    t.integer "is_reserved",       limit: 1,     default: 0
    t.integer "min_amount",        limit: 4,     default: 0
  end

  add_index "civicrm_price_set", ["domain_id"], name: "FK_civicrm_price_set_domain_id", using: :btree
  add_index "civicrm_price_set", ["financial_type_id"], name: "FK_civicrm_price_set_financial_type_id", using: :btree
  add_index "civicrm_price_set", ["name"], name: "UI_name", unique: true, using: :btree

  create_table "civicrm_price_set_entity", force: :cascade do |t|
    t.string  "entity_table", limit: 64, null: false
    t.integer "entity_id",    limit: 4,  null: false
    t.integer "price_set_id", limit: 4,  null: false
  end

  add_index "civicrm_price_set_entity", ["entity_table", "entity_id"], name: "UI_entity", unique: true, using: :btree
  add_index "civicrm_price_set_entity", ["price_set_id"], name: "FK_civicrm_price_set_entity_price_set_id", using: :btree

  create_table "civicrm_print_label", force: :cascade do |t|
    t.string  "title",             limit: 255
    t.string  "name",              limit: 255
    t.text    "description",       limit: 65535
    t.string  "label_format_name", limit: 255
    t.integer "label_type_id",     limit: 4
    t.text    "data",              limit: 4294967295
    t.integer "is_default",        limit: 1,          default: 1
    t.integer "is_active",         limit: 1,          default: 1
    t.integer "is_reserved",       limit: 1,          default: 1
    t.integer "created_id",        limit: 4
  end

  add_index "civicrm_print_label", ["created_id"], name: "FK_civicrm_print_label_created_id", using: :btree

  create_table "civicrm_product", force: :cascade do |t|
    t.string  "name",                   limit: 255,                                                null: false
    t.text    "description",            limit: 65535
    t.string  "sku",                    limit: 50
    t.text    "options",                limit: 65535
    t.string  "image",                  limit: 255
    t.string  "thumbnail",              limit: 255
    t.decimal "price",                                precision: 20, scale: 2
    t.string  "currency",               limit: 3
    t.integer "financial_type_id",      limit: 4
    t.decimal "min_contribution",                     precision: 20, scale: 2
    t.decimal "cost",                                 precision: 20, scale: 2
    t.integer "is_active",              limit: 1,                                                  null: false
    t.string  "period_type",            limit: 8,                              default: "rolling"
    t.integer "fixed_period_start_day", limit: 4,                              default: 101
    t.string  "duration_unit",          limit: 8,                              default: "year"
    t.integer "duration_interval",      limit: 4
    t.string  "frequency_unit",         limit: 8,                              default: "month"
    t.integer "frequency_interval",     limit: 4
  end

  add_index "civicrm_product", ["financial_type_id"], name: "FK_civicrm_product_financial_type_id", using: :btree

  create_table "civicrm_queue_item", force: :cascade do |t|
    t.string   "queue_name",   limit: 64,    null: false
    t.integer  "weight",       limit: 4,     null: false
    t.datetime "submit_time",                null: false
    t.datetime "release_time"
    t.text     "data",         limit: 65535
  end

  add_index "civicrm_queue_item", ["queue_name", "weight", "id"], name: "index_queueids", using: :btree

  create_table "civicrm_recurring_entity", force: :cascade do |t|
    t.integer "parent_id",    limit: 4,              null: false
    t.integer "entity_id",    limit: 4
    t.string  "entity_table", limit: 64,             null: false
    t.integer "mode",         limit: 1,  default: 1, null: false
  end

  create_table "civicrm_relationship", force: :cascade do |t|
    t.integer "contact_id_a",         limit: 4,               null: false
    t.integer "contact_id_b",         limit: 4,               null: false
    t.integer "relationship_type_id", limit: 4,               null: false
    t.date    "start_date"
    t.date    "end_date"
    t.integer "is_active",            limit: 1,   default: 1
    t.string  "description",          limit: 255
    t.integer "is_permission_a_b",    limit: 1,   default: 0
    t.integer "is_permission_b_a",    limit: 1,   default: 0
    t.integer "case_id",              limit: 4
  end

  add_index "civicrm_relationship", ["case_id"], name: "FK_civicrm_relationship_case_id", using: :btree
  add_index "civicrm_relationship", ["contact_id_a"], name: "FK_civicrm_relationship_contact_id_a", using: :btree
  add_index "civicrm_relationship", ["contact_id_b"], name: "FK_civicrm_relationship_contact_id_b", using: :btree
  add_index "civicrm_relationship", ["relationship_type_id"], name: "FK_civicrm_relationship_relationship_type_id", using: :btree

  create_table "civicrm_relationship_type", force: :cascade do |t|
    t.string  "name_a_b",           limit: 64
    t.string  "label_a_b",          limit: 64
    t.string  "name_b_a",           limit: 64
    t.string  "label_b_a",          limit: 64
    t.string  "description",        limit: 255
    t.string  "contact_type_a",     limit: 12
    t.string  "contact_type_b",     limit: 12
    t.string  "contact_sub_type_a", limit: 64
    t.string  "contact_sub_type_b", limit: 64
    t.integer "is_reserved",        limit: 1
    t.integer "is_active",          limit: 1,   default: 1
  end

  add_index "civicrm_relationship_type", ["name_a_b"], name: "UI_name_a_b", unique: true, using: :btree
  add_index "civicrm_relationship_type", ["name_b_a"], name: "UI_name_b_a", unique: true, using: :btree

  create_table "civicrm_report_instance", force: :cascade do |t|
    t.integer "domain_id",     limit: 4,                 null: false
    t.string  "title",         limit: 255
    t.string  "report_id",     limit: 64,                null: false
    t.string  "name",          limit: 255
    t.string  "args",          limit: 255
    t.string  "description",   limit: 255
    t.string  "permission",    limit: 255
    t.string  "grouprole",     limit: 1024
    t.text    "form_values",   limit: 65535
    t.integer "is_active",     limit: 1
    t.string  "email_subject", limit: 255
    t.text    "email_to",      limit: 65535
    t.text    "email_cc",      limit: 65535
    t.text    "header",        limit: 65535
    t.text    "footer",        limit: 65535
    t.integer "navigation_id", limit: 4
    t.integer "drilldown_id",  limit: 4
    t.integer "is_reserved",   limit: 1,     default: 0
    t.integer "created_id",    limit: 4
    t.integer "owner_id",      limit: 4
  end

  add_index "civicrm_report_instance", ["created_id"], name: "FK_civicrm_report_instance_created_id", using: :btree
  add_index "civicrm_report_instance", ["domain_id"], name: "FK_civicrm_report_instance_domain_id", using: :btree
  add_index "civicrm_report_instance", ["drilldown_id"], name: "FK_civicrm_report_instance_drilldown_id", using: :btree
  add_index "civicrm_report_instance", ["navigation_id"], name: "FK_civicrm_report_instance_navigation_id", using: :btree
  add_index "civicrm_report_instance", ["owner_id"], name: "FK_civicrm_report_instance_owner_id", using: :btree

  create_table "civicrm_saved_search", force: :cascade do |t|
    t.text    "form_values",      limit: 65535
    t.integer "mapping_id",       limit: 4
    t.integer "search_custom_id", limit: 4
    t.text    "where_clause",     limit: 65535
    t.text    "select_tables",    limit: 65535
    t.text    "where_tables",     limit: 65535
  end

  add_index "civicrm_saved_search", ["mapping_id"], name: "FK_civicrm_saved_search_mapping_id", using: :btree

  create_table "civicrm_setting", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "value",        limit: 65535
    t.integer  "domain_id",    limit: 4,     null: false
    t.integer  "contact_id",   limit: 4
    t.integer  "is_domain",    limit: 1
    t.integer  "component_id", limit: 4
    t.datetime "created_date"
    t.integer  "created_id",   limit: 4
  end

  add_index "civicrm_setting", ["component_id"], name: "FK_civicrm_setting_component_id", using: :btree
  add_index "civicrm_setting", ["contact_id"], name: "FK_civicrm_setting_contact_id", using: :btree
  add_index "civicrm_setting", ["created_id"], name: "FK_civicrm_setting_created_id", using: :btree
  add_index "civicrm_setting", ["domain_id", "contact_id", "name"], name: "index_domain_contact_name", unique: true, using: :btree

  create_table "civicrm_sms_provider", force: :cascade do |t|
    t.string  "name",       limit: 64
    t.string  "title",      limit: 64
    t.string  "username",   limit: 255
    t.string  "password",   limit: 255
    t.integer "api_type",   limit: 4,                 null: false
    t.string  "api_url",    limit: 128
    t.text    "api_params", limit: 65535
    t.integer "is_default", limit: 1,     default: 0
    t.integer "is_active",  limit: 1,     default: 0
    t.integer "domain_id",  limit: 4
  end

  add_index "civicrm_sms_provider", ["domain_id"], name: "FK_civicrm_sms_provider_domain_id", using: :btree

  create_table "civicrm_state_province", force: :cascade do |t|
    t.string  "name",         limit: 64
    t.string  "abbreviation", limit: 4
    t.integer "country_id",   limit: 4,  null: false
  end

  add_index "civicrm_state_province", ["country_id"], name: "FK_civicrm_state_province_country_id", using: :btree
  add_index "civicrm_state_province", ["name", "country_id"], name: "UI_name_country_id", unique: true, using: :btree

  create_table "civicrm_status_pref", force: :cascade do |t|
    t.integer "domain_id",       limit: 4,               null: false
    t.string  "name",            limit: 255,             null: false
    t.date    "hush_until"
    t.integer "ignore_severity", limit: 4,   default: 1
    t.string  "prefs",           limit: 255
    t.string  "check_info",      limit: 255
  end

  add_index "civicrm_status_pref", ["domain_id"], name: "FK_civicrm_status_pref_domain_id", using: :btree
  add_index "civicrm_status_pref", ["name"], name: "UI_status_pref_name", using: :btree

  create_table "civicrm_subscription_history", force: :cascade do |t|
    t.integer  "contact_id", limit: 4,   null: false
    t.integer  "group_id",   limit: 4
    t.datetime "date",                   null: false
    t.string   "method",     limit: 8
    t.string   "status",     limit: 8
    t.string   "tracking",   limit: 255
  end

  add_index "civicrm_subscription_history", ["contact_id"], name: "FK_civicrm_subscription_history_contact_id", using: :btree
  add_index "civicrm_subscription_history", ["group_id"], name: "FK_civicrm_subscription_history_group_id", using: :btree

  create_table "civicrm_survey", force: :cascade do |t|
    t.string   "title",                      limit: 255,               null: false
    t.integer  "campaign_id",                limit: 4
    t.integer  "activity_type_id",           limit: 4
    t.text     "recontact_interval",         limit: 65535
    t.text     "instructions",               limit: 65535
    t.integer  "release_frequency",          limit: 4
    t.integer  "max_number_of_contacts",     limit: 4
    t.integer  "default_number_of_contacts", limit: 4
    t.integer  "is_active",                  limit: 1,     default: 1
    t.integer  "is_default",                 limit: 1,     default: 0
    t.integer  "created_id",                 limit: 4
    t.datetime "created_date"
    t.integer  "last_modified_id",           limit: 4
    t.datetime "last_modified_date"
    t.integer  "result_id",                  limit: 4
    t.integer  "bypass_confirm",             limit: 1,     default: 0
    t.string   "thankyou_title",             limit: 255
    t.text     "thankyou_text",              limit: 65535
    t.integer  "is_share",                   limit: 1,     default: 1
  end

  add_index "civicrm_survey", ["activity_type_id"], name: "UI_activity_type_id", using: :btree
  add_index "civicrm_survey", ["campaign_id"], name: "FK_civicrm_survey_campaign_id", using: :btree
  add_index "civicrm_survey", ["created_id"], name: "FK_civicrm_survey_created_id", using: :btree
  add_index "civicrm_survey", ["last_modified_id"], name: "FK_civicrm_survey_last_modified_id", using: :btree

  create_table "civicrm_system_log", force: :cascade do |t|
    t.string   "message",    limit: 128,                         null: false
    t.text     "context",    limit: 4294967295
    t.string   "level",      limit: 9,          default: "info"
    t.datetime "timestamp",                                      null: false
    t.integer  "contact_id", limit: 4
    t.string   "hostname",   limit: 128
  end

  create_table "civicrm_tag", force: :cascade do |t|
    t.string   "name",          limit: 64,              null: false
    t.string   "description",   limit: 255
    t.integer  "parent_id",     limit: 4
    t.integer  "is_selectable", limit: 1,   default: 1
    t.integer  "is_reserved",   limit: 1,   default: 0
    t.integer  "is_tagset",     limit: 1,   default: 0
    t.string   "used_for",      limit: 64
    t.integer  "created_id",    limit: 4
    t.datetime "created_date"
    t.string   "color",         limit: 255
  end

  add_index "civicrm_tag", ["created_id"], name: "FK_civicrm_tag_created_id", using: :btree
  add_index "civicrm_tag", ["name"], name: "UI_name", unique: true, using: :btree
  add_index "civicrm_tag", ["parent_id"], name: "FK_civicrm_tag_parent_id", using: :btree

  create_table "civicrm_tell_friend", force: :cascade do |t|
    t.string  "entity_table",      limit: 64,    null: false
    t.integer "entity_id",         limit: 4,     null: false
    t.string  "title",             limit: 255
    t.text    "intro",             limit: 65535
    t.text    "suggested_message", limit: 65535
    t.string  "general_link",      limit: 255
    t.string  "thankyou_title",    limit: 255
    t.text    "thankyou_text",     limit: 65535
    t.integer "is_active",         limit: 1
  end

  create_table "civicrm_timezone", force: :cascade do |t|
    t.string  "name",         limit: 64
    t.string  "abbreviation", limit: 3
    t.string  "gmt",          limit: 64
    t.integer "offset",       limit: 4
    t.integer "country_id",   limit: 4,  null: false
  end

  add_index "civicrm_timezone", ["country_id"], name: "FK_civicrm_timezone_country_id", using: :btree

  create_table "civicrm_uf_field", force: :cascade do |t|
    t.integer "uf_group_id",      limit: 4,                                          null: false
    t.string  "field_name",       limit: 64,                                         null: false
    t.integer "is_active",        limit: 1,     default: 1
    t.integer "is_view",          limit: 1,     default: 0
    t.integer "is_required",      limit: 1,     default: 0
    t.integer "weight",           limit: 4,     default: 1,                          null: false
    t.text    "help_post",        limit: 65535
    t.text    "help_pre",         limit: 65535
    t.string  "visibility",       limit: 32,    default: "User and User Admin Only"
    t.integer "in_selector",      limit: 1,     default: 0
    t.integer "is_searchable",    limit: 1,     default: 0
    t.integer "location_type_id", limit: 4
    t.integer "phone_type_id",    limit: 4
    t.integer "website_type_id",  limit: 4
    t.string  "label",            limit: 255,                                        null: false
    t.string  "field_type",       limit: 255
    t.integer "is_reserved",      limit: 1
    t.integer "is_multi_summary", limit: 1,     default: 0
  end

  add_index "civicrm_uf_field", ["location_type_id"], name: "FK_civicrm_uf_field_location_type_id", using: :btree
  add_index "civicrm_uf_field", ["uf_group_id"], name: "FK_civicrm_uf_field_uf_group_id", using: :btree
  add_index "civicrm_uf_field", ["website_type_id"], name: "IX_website_type_id", using: :btree

  create_table "civicrm_uf_group", force: :cascade do |t|
    t.integer  "is_active",               limit: 1,     default: 1
    t.string   "group_type",              limit: 255
    t.string   "title",                   limit: 64,                null: false
    t.text     "description",             limit: 65535
    t.text     "help_pre",                limit: 65535
    t.text     "help_post",               limit: 65535
    t.integer  "limit_listings_group_id", limit: 4
    t.string   "post_URL",                limit: 255
    t.integer  "add_to_group_id",         limit: 4
    t.integer  "add_captcha",             limit: 1,     default: 0
    t.integer  "is_map",                  limit: 1,     default: 0
    t.integer  "is_edit_link",            limit: 1,     default: 0
    t.integer  "is_uf_link",              limit: 1,     default: 0
    t.integer  "is_update_dupe",          limit: 1,     default: 0
    t.string   "cancel_URL",              limit: 255
    t.integer  "is_cms_user",             limit: 1,     default: 0
    t.text     "notify",                  limit: 65535
    t.integer  "is_reserved",             limit: 1
    t.string   "name",                    limit: 64
    t.integer  "created_id",              limit: 4
    t.datetime "created_date"
    t.integer  "is_proximity_search",     limit: 1,     default: 0
  end

  add_index "civicrm_uf_group", ["add_to_group_id"], name: "FK_civicrm_uf_group_add_to_group_id", using: :btree
  add_index "civicrm_uf_group", ["created_id"], name: "FK_civicrm_uf_group_created_id", using: :btree
  add_index "civicrm_uf_group", ["limit_listings_group_id"], name: "FK_civicrm_uf_group_limit_listings_group_id", using: :btree
  add_index "civicrm_uf_group", ["name"], name: "UI_name", unique: true, using: :btree

  create_table "civicrm_uf_join", force: :cascade do |t|
    t.integer "is_active",    limit: 1,          default: 1
    t.string  "module",       limit: 64,                     null: false
    t.string  "entity_table", limit: 64
    t.integer "entity_id",    limit: 4
    t.integer "weight",       limit: 4,          default: 1, null: false
    t.integer "uf_group_id",  limit: 4,                      null: false
    t.text    "module_data",  limit: 4294967295
  end

  add_index "civicrm_uf_join", ["entity_table", "entity_id"], name: "index_entity", using: :btree
  add_index "civicrm_uf_join", ["uf_group_id"], name: "FK_civicrm_uf_join_uf_group_id", using: :btree

  create_table "civicrm_uf_match", force: :cascade do |t|
    t.integer "domain_id",  limit: 4,   null: false
    t.integer "uf_id",      limit: 4,   null: false
    t.string  "uf_name",    limit: 128
    t.integer "contact_id", limit: 4
    t.string  "language",   limit: 5
  end

  add_index "civicrm_uf_match", ["contact_id", "domain_id"], name: "UI_contact_domain_id", unique: true, using: :btree
  add_index "civicrm_uf_match", ["domain_id"], name: "FK_civicrm_uf_match_domain_id", using: :btree
  add_index "civicrm_uf_match", ["uf_id"], name: "I_civicrm_uf_match_uf_id", using: :btree
  add_index "civicrm_uf_match", ["uf_name", "domain_id"], name: "UI_uf_name_domain_id", unique: true, using: :btree

  create_table "civicrm_value_assimilations_4", force: :cascade do |t|
    t.integer  "entity_id",                           limit: 4,                  null: false
    t.datetime "foundations_truth_17"
    t.datetime "foundations_freedom_18"
    t.datetime "foundations_service_19"
    t.datetime "foundations_community_20"
    t.datetime "membership_approved_22"
    t.datetime "membership_application_filed_dat_23"
    t.string   "membership_letter_sent_40",           limit: 255
    t.string   "membership_status_101",               limit: 255, default: "NA"
    t.datetime "membership_inactive_since_102"
    t.datetime "mbt_week_1_165"
    t.datetime "mbt_week_2_166"
    t.datetime "mbt_week_3_167"
    t.datetime "mbt_week_4_168"
    t.datetime "mbt_week_5_169"
    t.datetime "mbt_week_6_170"
  end

  add_index "civicrm_value_assimilations_4", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_assimilations_4", ["foundations_community_20"], name: "INDEX_foundations_community_20", using: :btree
  add_index "civicrm_value_assimilations_4", ["foundations_freedom_18"], name: "INDEX_foundations_freedom_18", using: :btree
  add_index "civicrm_value_assimilations_4", ["foundations_service_19"], name: "INDEX_foundations_service_19", using: :btree
  add_index "civicrm_value_assimilations_4", ["foundations_truth_17"], name: "INDEX_foundations_truth_17", using: :btree
  add_index "civicrm_value_assimilations_4", ["mbt_week_1_165"], name: "INDEX_mbt_week_1_165", using: :btree
  add_index "civicrm_value_assimilations_4", ["mbt_week_2_166"], name: "INDEX_mbt_week_2_166", using: :btree
  add_index "civicrm_value_assimilations_4", ["mbt_week_3_167"], name: "INDEX_mbt_week_3_167", using: :btree
  add_index "civicrm_value_assimilations_4", ["mbt_week_4_168"], name: "INDEX_mbt_week_4_168", using: :btree
  add_index "civicrm_value_assimilations_4", ["mbt_week_5_169"], name: "INDEX_mbt_week_5_169", using: :btree
  add_index "civicrm_value_assimilations_4", ["mbt_week_6_170"], name: "INDEX_mbt_week_6_170", using: :btree
  add_index "civicrm_value_assimilations_4", ["membership_approved_22"], name: "INDEX_membership_approved_22", using: :btree
  add_index "civicrm_value_assimilations_4", ["membership_letter_sent_40"], name: "INDEX_membership_letter_sent_40", using: :btree
  add_index "civicrm_value_assimilations_4", ["membership_status_101"], name: "INDEX_membership_status_101", using: :btree

  create_table "civicrm_value_baptism_interest_info_15", force: :cascade do |t|
    t.integer  "entity_id",                limit: 4,     null: false
    t.string   "baptism_approval_49",      limit: 255
    t.datetime "baptism_approval_date_50"
    t.text     "baptism_interest_note_51", limit: 65535
    t.string   "baptism_service_52",       limit: 255
  end

  add_index "civicrm_value_baptism_interest_info_15", ["baptism_approval_49"], name: "INDEX_baptism_approval_49", using: :btree
  add_index "civicrm_value_baptism_interest_info_15", ["baptism_approval_date_50"], name: "INDEX_baptism_approval_date_50", using: :btree
  add_index "civicrm_value_baptism_interest_info_15", ["baptism_service_52"], name: "INDEX_baptism_service_52", using: :btree
  add_index "civicrm_value_baptism_interest_info_15", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree

  create_table "civicrm_value_child_checkin_children_31", force: :cascade do |t|
    t.integer "entity_id",                           limit: 4,                    null: false
    t.integer "child_checkin_name_108",              limit: 4
    t.string  "household_checkin_status_116",        limit: 255, default: "Out"
    t.string  "household_checkin_classroom_117",     limit: 255, default: "None"
    t.string  "household_checkin_notes_118",         limit: 255
    t.string  "household_checkin_pagetimestamp_163", limit: 255
  end

  add_index "civicrm_value_child_checkin_children_31", ["child_checkin_name_108"], name: "INDEX_child_checkin_name_108", using: :btree
  add_index "civicrm_value_child_checkin_children_31", ["entity_id"], name: "FK_civicrm_value_child_checkin_chil_43d48414d5ec1f71", using: :btree
  add_index "civicrm_value_child_checkin_children_31", ["household_checkin_classroom_117"], name: "INDEX_household_checkin_classroom_117", using: :btree
  add_index "civicrm_value_child_checkin_children_31", ["household_checkin_status_116"], name: "INDEX_household_checkin_status_116", using: :btree

  create_table "civicrm_value_church_plant_retreat_48", force: :cascade do |t|
    t.integer "entity_id",                            limit: 4,   null: false
    t.string  "please_list_any_special_dietary__196", limit: 150
  end

  add_index "civicrm_value_church_plant_retreat_48", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_church_plant_retreat_48", ["please_list_any_special_dietary__196"], name: "INDEX_please_list_any_special_dietary__196", using: :btree

  create_table "civicrm_value_civivolunteer_55", force: :cascade do |t|
    t.integer "entity_id",                     limit: 4,  null: false
    t.integer "volunteer_need_id_211",         limit: 4
    t.string  "volunteer_role_id_212",         limit: 64
    t.integer "time_scheduled_in_minutes_213", limit: 4
    t.integer "time_completed_in_minutes_214", limit: 4
  end

  add_index "civicrm_value_civivolunteer_55", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_civivolunteer_55", ["volunteer_role_id_212"], name: "INDEX_volunteer_role_id_212", using: :btree

  create_table "civicrm_value_clear_river_series_47", force: :cascade do |t|
    t.integer "entity_id",                            limit: 4,  null: false
    t.float   "number_of_children_needing_child_194", limit: 53
    t.float   "number_of_children_needing_child_195", limit: 53
  end

  add_index "civicrm_value_clear_river_series_47", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_clear_river_series_47", ["number_of_children_needing_child_194"], name: "INDEX_number_of_children_needing_child_194", using: :btree
  add_index "civicrm_value_clear_river_series_47", ["number_of_children_needing_child_195"], name: "INDEX_number_of_children_needing_child_195", using: :btree

  create_table "civicrm_value_contribution_years_8", force: :cascade do |t|
    t.integer "entity_id",                  limit: 4,             null: false
    t.integer "year_2011_29",               limit: 1
    t.integer "year_2012_30",               limit: 1
    t.integer "donate_2010_31",             limit: 1
    t.integer "paper_giving_statement_185", limit: 1, default: 0
  end

  add_index "civicrm_value_contribution_years_8", ["donate_2010_31"], name: "INDEX_donate_2010_31", using: :btree
  add_index "civicrm_value_contribution_years_8", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_contribution_years_8", ["paper_giving_statement_185"], name: "INDEX_paper_giving_statement_185", using: :btree
  add_index "civicrm_value_contribution_years_8", ["year_2012_30"], name: "INDEX_year_2012_30", using: :btree

  create_table "civicrm_value_core_events_34", force: :cascade do |t|
    t.integer  "entity_id",                       limit: 4, null: false
    t.datetime "summer_conference_122"
    t.datetime "winter_conference_123"
    t.datetime "newcomer_lunch_124"
    t.datetime "fall_retreat_125"
    t.datetime "small_group_leader_retreat_126"
    t.datetime "learning_to_pray_for_others_127"
    t.datetime "baptism_161"
  end

  add_index "civicrm_value_core_events_34", ["baptism_161"], name: "INDEX_baptism_161", using: :btree
  add_index "civicrm_value_core_events_34", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_core_events_34", ["learning_to_pray_for_others_127"], name: "INDEX_learning_to_pray_for_others_127", using: :btree
  add_index "civicrm_value_core_events_34", ["newcomer_lunch_124"], name: "INDEX_newcomer_lunch_124", using: :btree

  create_table "civicrm_value_crkids_barcode_22", force: :cascade do |t|
    t.integer "entity_id",            limit: 4,                 null: false
    t.float   "crkids_barcodeid_112", limit: 53,  default: 0.0
    t.string  "pager_113",            limit: 255
  end

  add_index "civicrm_value_crkids_barcode_22", ["crkids_barcodeid_112"], name: "INDEX_crkids_barcodeid_112", using: :btree
  add_index "civicrm_value_crkids_barcode_22", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree

  create_table "civicrm_value_event_fields_44", force: :cascade do |t|
    t.integer "entity_id",                            limit: 4,   null: false
    t.string  "dietary_needs_171",                    limit: 255
    t.string  "grade_175",                            limit: 255
    t.string  "special_instructions_176",             limit: 255
    t.string  "emergency_contact_177",                limit: 255
    t.string  "parent_guardian_name_178",             limit: 255
    t.string  "is_your_child_registered_with_cl_179", limit: 255
    t.float   "number_of_children_needing_child_181", limit: 53
    t.float   "number_of_children_needing_child_182", limit: 53
    t.string  "roommate_request__183",                limit: 255
    t.string  "please_select_your_church_184",        limit: 255
    t.string  "i_m_an_international_189",             limit: 255
    t.string  "i_m_bringing_an_international_fr_190", limit: 255
    t.string  "if_you_re_an_international_who_i_191", limit: 255
  end

  add_index "civicrm_value_event_fields_44", ["dietary_needs_171"], name: "INDEX_dietary_needs_171", using: :btree
  add_index "civicrm_value_event_fields_44", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_event_fields_44", ["grade_175"], name: "INDEX_grade_175", using: :btree
  add_index "civicrm_value_event_fields_44", ["if_you_re_an_international_who_i_191"], name: "INDEX_if_you_re_an_international_who_i_191", using: :btree
  add_index "civicrm_value_event_fields_44", ["number_of_children_needing_child_181"], name: "INDEX_number_of_children_needing_child_181", using: :btree
  add_index "civicrm_value_event_fields_44", ["number_of_children_needing_child_182"], name: "INDEX_number_of_children_needing_child_182", using: :btree
  add_index "civicrm_value_event_fields_44", ["please_select_your_church_184"], name: "INDEX_please_select_your_church_184", using: :btree
  add_index "civicrm_value_event_fields_44", ["roommate_request__183"], name: "INDEX_roommate_request__183", using: :btree
  add_index "civicrm_value_event_fields_44", ["special_instructions_176"], name: "INDEX_special_instructions_176", using: :btree

  create_table "civicrm_value_fall_area_conference_50", force: :cascade do |t|
    t.integer "entity_id",                            limit: 4,   null: false
    t.string  "please_select_your_church__201",       limit: 255
    t.string  "are_you_bringing_a_baby_under_12_202", limit: 255
  end

  add_index "civicrm_value_fall_area_conference_50", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_fall_area_conference_50", ["please_select_your_church__201"], name: "INDEX_please_select_your_church__201", using: :btree

  create_table "civicrm_value_first_time_visitor_2", force: :cascade do |t|
    t.integer  "entity_id",                      limit: 4,                   null: false
    t.integer  "visiting_from_out_of_town_10",   limit: 1
    t.string   "how_did_they_hear_about_us__11", limit: 255
    t.datetime "welcome_card_date_12"
    t.string   "service_attended_13",            limit: 255
    t.string   "this_is_my_14",                  limit: 255
    t.string   "email_sent_42",                  limit: 255, default: "N/A"
    t.string   "welcome_letter_sent_43",         limit: 255, default: "N/A"
  end

  add_index "civicrm_value_first_time_visitor_2", ["email_sent_42"], name: "INDEX_email_sent_42", using: :btree
  add_index "civicrm_value_first_time_visitor_2", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_first_time_visitor_2", ["service_attended_13"], name: "INDEX_service_attended_13", using: :btree
  add_index "civicrm_value_first_time_visitor_2", ["this_is_my_14"], name: "INDEX_this_is_my_14", using: :btree
  add_index "civicrm_value_first_time_visitor_2", ["visiting_from_out_of_town_10"], name: "INDEX_visiting_from_out_of_town_10", using: :btree
  add_index "civicrm_value_first_time_visitor_2", ["welcome_card_date_12"], name: "INDEX_welcome_card_date_12", using: :btree
  add_index "civicrm_value_first_time_visitor_2", ["welcome_letter_sent_43"], name: "INDEX_welcome_letter_sent_43", using: :btree

  create_table "civicrm_value_kids_checkin_21", force: :cascade do |t|
    t.integer "entity_id",            limit: 4,     null: false
    t.integer "authorized_68",        limit: 4
    t.text    "child1_note_71",       limit: 65535
    t.integer "authorized_status_73", limit: 1
  end

  add_index "civicrm_value_kids_checkin_21", ["authorized_68"], name: "FK_civicrm_value_kids_checkin_21_authorized_68", using: :btree
  add_index "civicrm_value_kids_checkin_21", ["entity_id"], name: "FK_civicrm_value_kids_checkin_21_entity_id", using: :btree

  create_table "civicrm_value_ksa_49", force: :cascade do |t|
    t.integer "entity_id",                            limit: 4,   null: false
    t.string  "is_your_child_registered_with_cl_198", limit: 255
    t.string  "what_grade_is_your_child_enterin_199", limit: 255
  end

  add_index "civicrm_value_ksa_49", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree

  create_table "civicrm_value_network_leadership_conferece_46", force: :cascade do |t|
    t.integer "entity_id",                            limit: 4,   null: false
    t.string  "please_select_your_church__192",       limit: 255
    t.string  "are_you_bringing_a_nursing_baby__193", limit: 255
  end

  add_index "civicrm_value_network_leadership_conferece_46", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_network_leadership_conferece_46", ["please_select_your_church__192"], name: "INDEX_please_select_your_church__192", using: :btree

  create_table "civicrm_value_relationships_field_set_13", force: :cascade do |t|
    t.integer "entity_id",  limit: 4, null: false
    t.integer "spouses_45", limit: 4
  end

  add_index "civicrm_value_relationships_field_set_13", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_relationships_field_set_13", ["spouses_45"], name: "FK_civicrm_value_relationships_fiel_8a76fb82520e9893", using: :btree

  create_table "civicrm_value_serving_notes_16", force: :cascade do |t|
    t.integer "entity_id",        limit: 4,   null: false
    t.string  "serving_notes_53", limit: 255
    t.integer "overseer_200",     limit: 4
  end

  add_index "civicrm_value_serving_notes_16", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_serving_notes_16", ["overseer_200"], name: "INDEX_overseer_200", using: :btree
  add_index "civicrm_value_serving_notes_16", ["serving_notes_53"], name: "INDEX_serving_notes_53", using: :btree

  create_table "civicrm_value_small_group_32", force: :cascade do |t|
    t.integer "entity_id",                   limit: 4,   null: false
    t.integer "is_active_sg_member_114",     limit: 1
    t.integer "group_leader_115",            limit: 4
    t.integer "small_group_leader_147",      limit: 4
    t.string  "small_group_member_role_158", limit: 255
  end

  add_index "civicrm_value_small_group_32", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_small_group_32", ["group_leader_115"], name: "INDEX_group_leader_115", using: :btree
  add_index "civicrm_value_small_group_32", ["small_group_leader_147"], name: "INDEX_small_group_leader_147", using: :btree
  add_index "civicrm_value_small_group_32", ["small_group_member_role_158"], name: "INDEX_small_group_member_label_158", using: :btree

  create_table "civicrm_value_stock_gifts_33", force: :cascade do |t|
    t.integer "entity_id",                limit: 4,   null: false
    t.string  "ticker_symbol_119",        limit: 255
    t.float   "shares_120",               limit: 53
    t.string  "notes_for_stock_gift_121", limit: 255
  end

  add_index "civicrm_value_stock_gifts_33", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_stock_gifts_33", ["shares_120"], name: "INDEX_shares_120", using: :btree
  add_index "civicrm_value_stock_gifts_33", ["ticker_symbol_119"], name: "INDEX_ticker_symbol_119", using: :btree

  create_table "civicrm_value_ubercart_purchases_43", force: :cascade do |t|
    t.integer "entity_id",         limit: 4,   null: false
    t.string  "sales_tax_159",     limit: 255
    t.string  "shipping_cost_160", limit: 255
  end

  add_index "civicrm_value_ubercart_purchases_43", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree

  create_table "civicrm_value_volunteer_commendation_57", force: :cascade do |t|
    t.integer "entity_id",                limit: 4, null: false
    t.integer "volunteer_project_id_216", limit: 4
  end

  add_index "civicrm_value_volunteer_commendation_57", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree

  create_table "civicrm_value_volunteer_information_56", force: :cascade do |t|
    t.integer "entity_id",              limit: 4,   null: false
    t.string  "camera_skill_level_215", limit: 255
  end

  add_index "civicrm_value_volunteer_information_56", ["camera_skill_level_215"], name: "INDEX_camera_skill_level_215", using: :btree
  add_index "civicrm_value_volunteer_information_56", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree

  create_table "civicrm_value_youth_35", force: :cascade do |t|
    t.integer "entity_id",                        limit: 4,   null: false
    t.string  "parent_s_email_129",               limit: 255
    t.string  "parent_s_phone_131",               limit: 255
    t.float   "grade_in_school_132",              limit: 53
    t.string  "high_school_district_133",         limit: 255
    t.integer "do_you_text__134",                 limit: 1
    t.integer "does_parent_text__135",            limit: 1
    t.integer "addition_parent_name_136",         limit: 4
    t.integer "parent_name_137",                  limit: 4
    t.string  "additional_parent_email_138",      limit: 255
    t.string  "additional_parent_phone_139",      limit: 255
    t.integer "does_additional_parent_text__140", limit: 1
  end

  add_index "civicrm_value_youth_35", ["addition_parent_name_136"], name: "FK_civicrm_value_youth_35_addition_parent_name_136", using: :btree
  add_index "civicrm_value_youth_35", ["entity_id"], name: "unique_entity_id", unique: true, using: :btree
  add_index "civicrm_value_youth_35", ["grade_in_school_132"], name: "INDEX_grade_in_school_132", using: :btree
  add_index "civicrm_value_youth_35", ["parent_name_137"], name: "FK_civicrm_value_youth_35_parent_name_137", using: :btree
  add_index "civicrm_value_youth_35", ["parent_s_email_129"], name: "INDEX_parent_s_email_129", using: :btree

  create_table "civicrm_view_case_activity_recent", id: false, force: :cascade do |t|
    t.integer  "case_id",            limit: 4,             null: false
    t.integer  "id",                 limit: 4, default: 0, null: false
    t.datetime "activity_date_time"
    t.integer  "status_id",          limit: 4
    t.integer  "activity_type_id",   limit: 4, default: 1, null: false
  end

  create_table "civicrm_view_case_activity_upcoming", id: false, force: :cascade do |t|
    t.integer  "case_id",            limit: 4,             null: false
    t.integer  "id",                 limit: 4, default: 0, null: false
    t.datetime "activity_date_time"
    t.integer  "status_id",          limit: 4
    t.integer  "activity_type_id",   limit: 4, default: 1, null: false
  end

  create_table "civicrm_volunteer_need", force: :cascade do |t|
    t.integer  "project_id",    limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "duration",      limit: 4
    t.integer  "is_flexible",   limit: 1, default: 0, null: false
    t.integer  "quantity",      limit: 4
    t.integer  "visibility_id", limit: 4
    t.integer  "role_id",       limit: 4
    t.integer  "is_active",     limit: 1, default: 1, null: false
  end

  add_index "civicrm_volunteer_need", ["id"], name: "UI_id", unique: true, using: :btree
  add_index "civicrm_volunteer_need", ["project_id"], name: "FK_civicrm_volunteer_need_project_id", using: :btree

  create_table "civicrm_volunteer_project", force: :cascade do |t|
    t.string  "title",        limit: 255,               null: false
    t.text    "description",  limit: 65535
    t.string  "entity_table", limit: 64
    t.integer "entity_id",    limit: 4
    t.integer "is_active",    limit: 1,     default: 1, null: false
    t.integer "loc_block_id", limit: 4
    t.integer "campaign_id",  limit: 4
  end

  add_index "civicrm_volunteer_project", ["campaign_id"], name: "FK_civicrm_volunteer_project_campaign_id", using: :btree
  add_index "civicrm_volunteer_project", ["loc_block_id"], name: "FK_civicrm_volunteer_project_loc_block_id", using: :btree

  create_table "civicrm_volunteer_project_contact", force: :cascade do |t|
    t.integer "project_id",           limit: 4, null: false
    t.integer "contact_id",           limit: 4, null: false
    t.integer "relationship_type_id", limit: 4, null: false
  end

  add_index "civicrm_volunteer_project_contact", ["contact_id"], name: "FK_civicrm_volunteer_project_contact_contact_id", using: :btree
  add_index "civicrm_volunteer_project_contact", ["project_id", "contact_id", "relationship_type_id"], name: "UI_project_contact_rel", unique: true, using: :btree

  create_table "civicrm_website", force: :cascade do |t|
    t.integer "contact_id",      limit: 4
    t.string  "url",             limit: 128
    t.integer "website_type_id", limit: 4
  end

  add_index "civicrm_website", ["contact_id"], name: "FK_civicrm_website_contact_id", using: :btree
  add_index "civicrm_website", ["website_type_id"], name: "UI_website_type_id", using: :btree

  create_table "civicrm_word_replacement", force: :cascade do |t|
    t.string  "find_word",    limit: 255
    t.string  "replace_word", limit: 255
    t.integer "is_active",    limit: 1,   default: 1
    t.string  "match_type",   limit: 16,  default: "wildcardMatch"
    t.integer "domain_id",    limit: 4
  end

  add_index "civicrm_word_replacement", ["domain_id", "find_word"], name: "UI_domain_find", unique: true, using: :btree

  create_table "civicrm_worldregion", force: :cascade do |t|
    t.string "name", limit: 128
  end

  create_table "colors", primary_key: "selector", force: :cascade do |t|
    t.binary "color",  limit: 4294967295,                    null: false
    t.string "module", limit: 128,        default: "colors", null: false
  end

  create_table "comment", primary_key: "cid", force: :cascade do |t|
    t.integer "pid",      limit: 4,   default: 0,  null: false
    t.integer "nid",      limit: 4,   default: 0,  null: false
    t.integer "uid",      limit: 4,   default: 0,  null: false
    t.string  "subject",  limit: 64,  default: "", null: false
    t.string  "hostname", limit: 128, default: "", null: false
    t.integer "created",  limit: 4,   default: 0,  null: false
    t.integer "changed",  limit: 4,   default: 0,  null: false
    t.integer "status",   limit: 1,   default: 1,  null: false
    t.string  "thread",   limit: 255,              null: false
    t.string  "name",     limit: 60
    t.string  "mail",     limit: 64
    t.string  "homepage", limit: 255
    t.string  "language", limit: 12,  default: "", null: false
  end

  add_index "comment", ["created"], name: "comment_created", using: :btree
  add_index "comment", ["nid", "language"], name: "comment_nid_language", using: :btree
  add_index "comment", ["nid", "status", "created", "cid", "thread"], name: "comment_num_new", using: :btree
  add_index "comment", ["pid", "status"], name: "comment_status_pid", using: :btree
  add_index "comment", ["uid"], name: "comment_uid", using: :btree

  create_table "cpn", primary_key: "nid", force: :cascade do |t|
    t.text "css",      limit: 4294967295
    t.text "js",       limit: 4294967295
    t.text "noscript", limit: 4294967295
  end

  create_table "ctools_css_cache", primary_key: "cid", force: :cascade do |t|
    t.string  "filename", limit: 255
    t.text    "css",      limit: 4294967295
    t.integer "filter",   limit: 1
  end

  create_table "ctools_object_cache", id: false, force: :cascade do |t|
    t.string  "sid",     limit: 64,                     null: false
    t.string  "name",    limit: 128,                    null: false
    t.string  "obj",     limit: 128,                    null: false
    t.integer "updated", limit: 4,          default: 0, null: false
    t.binary  "data",    limit: 4294967295
  end

  add_index "ctools_object_cache", ["updated"], name: "updated", using: :btree

  create_table "current_search", primary_key: "name", force: :cascade do |t|
    t.string "label",    limit: 255,   default: "", null: false
    t.text   "settings", limit: 65535
  end

  create_table "custom_churchnetwork_attendance", force: :cascade do |t|
    t.string  "Type",           limit: 255
    t.integer "Adult_Count",    limit: 4
    t.integer "Child_Count",    limit: 4
    t.date    "Date"
    t.integer "dc_group_id",    limit: 4
    t.integer "service_number", limit: 4,   default: 0
    t.integer "Worker_Count",   limit: 4
  end

  add_index "custom_churchnetwork_attendance", ["id"], name: "id", unique: true, using: :btree

  create_table "custom_smallgroup_attendance", force: :cascade do |t|
    t.integer "member_id",       limit: 4
    t.date    "activity_date"
    t.integer "sg_group_id",     limit: 4
    t.integer "dc_leader_id",    limit: 4
    t.integer "group_leader_id", limit: 4
    t.string  "activity_type",   limit: 255
    t.string  "member_role",     limit: 255
    t.integer "attended",        limit: 4,   default: 0
    t.string  "notes",           limit: 255
    t.binary  "is_deleted",      limit: 1,   default: "b'0'"
  end

  add_index "custom_smallgroup_attendance", ["member_id", "activity_date"], name: "member_id", unique: true, using: :btree

  create_table "custom_smallgroup_meeting_log", force: :cascade do |t|
    t.date    "meeting_date"
    t.integer "group_leader_cid", limit: 4
    t.string  "meeting_type",     limit: 255
    t.integer "group_group_id",   limit: 4
    t.integer "present_count",    limit: 4,   default: 0
    t.integer "dc_group_id",      limit: 4,   default: 0
    t.binary  "is_deleted",       limit: 1,   default: "b'0'"
  end

  create_table "date_format_locale", id: false, force: :cascade do |t|
    t.string "format",   limit: 100, null: false
    t.string "type",     limit: 64,  null: false
    t.string "language", limit: 12,  null: false
  end

  create_table "date_format_type", primary_key: "type", force: :cascade do |t|
    t.string  "title",  limit: 255,             null: false
    t.integer "locked", limit: 1,   default: 0, null: false
  end

  add_index "date_format_type", ["title"], name: "title", using: :btree

  create_table "date_formats", primary_key: "dfid", force: :cascade do |t|
    t.string  "format", limit: 100,             null: false
    t.string  "type",   limit: 64,              null: false
    t.integer "locked", limit: 1,   default: 0, null: false
  end

  add_index "date_formats", ["format", "type"], name: "formats", unique: true, using: :btree

  create_table "dedupe", primary_key: "id1", force: :cascade do |t|
    t.integer "id2",    limit: 4
    t.integer "weight", limit: 4
  end

  create_table "elysia_cron", primary_key: "name", force: :cascade do |t|
    t.integer "disable",             limit: 1
    t.string  "rule",                limit: 32
    t.integer "weight",              limit: 4
    t.string  "context",             limit: 32
    t.integer "running",             limit: 4,  default: 0,   null: false
    t.integer "last_run",            limit: 4,  default: 0,   null: false
    t.integer "last_aborted",        limit: 1,  default: 0,   null: false
    t.integer "abort_count",         limit: 4,  default: 0,   null: false
    t.string  "last_abort_function", limit: 32
    t.integer "last_execution_time", limit: 4,  default: 0,   null: false
    t.integer "execution_count",     limit: 4,  default: 0,   null: false
    t.float   "avg_execution_time",  limit: 24, default: 0.0, null: false
    t.integer "max_execution_time",  limit: 4,  default: 0,   null: false
    t.integer "last_shutdown_time",  limit: 4,  default: 0,   null: false
  end

  create_table "facetapi", primary_key: "name", force: :cascade do |t|
    t.string  "searcher", limit: 64,    default: "", null: false
    t.string  "realm",    limit: 64,    default: "", null: false
    t.string  "facet",    limit: 255,   default: "", null: false
    t.integer "enabled",  limit: 1,     default: 0,  null: false
    t.binary  "settings", limit: 65535
  end

  create_table "field_collection_item", primary_key: "item_id", force: :cascade do |t|
    t.string  "field_name",  limit: 32,             null: false
    t.integer "revision_id", limit: 4,              null: false
    t.integer "archived",    limit: 4,  default: 0, null: false
  end

  create_table "field_collection_item_revision", primary_key: "revision_id", force: :cascade do |t|
    t.integer "item_id", limit: 4, null: false
  end

  add_index "field_collection_item_revision", ["item_id"], name: "item_id", using: :btree

  create_table "field_config", force: :cascade do |t|
    t.string  "field_name",     limit: 32,                      null: false
    t.string  "type",           limit: 128,                     null: false
    t.string  "module",         limit: 128,        default: "", null: false
    t.integer "active",         limit: 1,          default: 0,  null: false
    t.string  "storage_type",   limit: 128,                     null: false
    t.string  "storage_module", limit: 128,        default: "", null: false
    t.integer "storage_active", limit: 1,          default: 0,  null: false
    t.integer "locked",         limit: 1,          default: 0,  null: false
    t.binary  "data",           limit: 4294967295,              null: false
    t.integer "cardinality",    limit: 1,          default: 0,  null: false
    t.integer "translatable",   limit: 1,          default: 0,  null: false
    t.integer "deleted",        limit: 1,          default: 0,  null: false
  end

  add_index "field_config", ["active"], name: "active", using: :btree
  add_index "field_config", ["deleted"], name: "deleted", using: :btree
  add_index "field_config", ["field_name"], name: "field_name", using: :btree
  add_index "field_config", ["module"], name: "module", using: :btree
  add_index "field_config", ["storage_active"], name: "storage_active", using: :btree
  add_index "field_config", ["storage_module"], name: "storage_module", using: :btree
  add_index "field_config", ["storage_type"], name: "storage_type", using: :btree
  add_index "field_config", ["type"], name: "type", using: :btree

  create_table "field_config_instance", force: :cascade do |t|
    t.integer "field_id",    limit: 4,                       null: false
    t.string  "field_name",  limit: 32,         default: "", null: false
    t.string  "entity_type", limit: 32,         default: "", null: false
    t.string  "bundle",      limit: 128,        default: "", null: false
    t.binary  "data",        limit: 4294967295,              null: false
    t.integer "deleted",     limit: 1,          default: 0,  null: false
  end

  add_index "field_config_instance", ["deleted"], name: "deleted", using: :btree
  add_index "field_config_instance", ["field_name", "entity_type", "bundle"], name: "field_name_bundle", using: :btree

  create_table "field_data_body", id: false, force: :cascade do |t|
    t.string  "entity_type",  limit: 128,        default: "", null: false
    t.string  "bundle",       limit: 128,        default: "", null: false
    t.integer "deleted",      limit: 1,          default: 0,  null: false
    t.integer "entity_id",    limit: 4,                       null: false
    t.integer "revision_id",  limit: 4
    t.string  "language",     limit: 32,         default: "", null: false
    t.integer "delta",        limit: 4,                       null: false
    t.text    "body_value",   limit: 4294967295
    t.text    "body_summary", limit: 4294967295
    t.string  "body_format",  limit: 255
  end

  add_index "field_data_body", ["body_format"], name: "body_format", using: :btree
  add_index "field_data_body", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_body", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_body", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_body", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_body", ["language"], name: "language", using: :btree
  add_index "field_data_body", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_comment_body", id: false, force: :cascade do |t|
    t.string  "entity_type",         limit: 128,        default: "", null: false
    t.string  "bundle",              limit: 128,        default: "", null: false
    t.integer "deleted",             limit: 1,          default: 0,  null: false
    t.integer "entity_id",           limit: 4,                       null: false
    t.integer "revision_id",         limit: 4
    t.string  "language",            limit: 32,         default: "", null: false
    t.integer "delta",               limit: 4,                       null: false
    t.text    "comment_body_value",  limit: 4294967295
    t.string  "comment_body_format", limit: 255
  end

  add_index "field_data_comment_body", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_comment_body", ["comment_body_format"], name: "comment_body_format", using: :btree
  add_index "field_data_comment_body", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_comment_body", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_comment_body", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_comment_body", ["language"], name: "language", using: :btree
  add_index "field_data_comment_body", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_barcode", id: false, force: :cascade do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false
    t.string  "bundle",              limit: 128, default: "", null: false
    t.integer "deleted",             limit: 1,   default: 0,  null: false
    t.integer "entity_id",           limit: 4,                null: false
    t.integer "revision_id",         limit: 4
    t.string  "language",            limit: 32,  default: "", null: false
    t.integer "delta",               limit: 4,                null: false
    t.string  "field_barcode_value", limit: 255
  end

  add_index "field_data_field_barcode", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_barcode", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_barcode", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_barcode", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_barcode", ["language"], name: "language", using: :btree
  add_index "field_data_field_barcode", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_civi_contact", id: false, force: :cascade do |t|
    t.string  "entity_type",                   limit: 128, default: "", null: false
    t.string  "bundle",                        limit: 128, default: "", null: false
    t.integer "deleted",                       limit: 1,   default: 0,  null: false
    t.integer "entity_id",                     limit: 4,                null: false
    t.integer "revision_id",                   limit: 4
    t.string  "language",                      limit: 32,  default: "", null: false
    t.integer "delta",                         limit: 4,                null: false
    t.integer "field_civi_contact_contact_id", limit: 4
  end

  add_index "field_data_field_civi_contact", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_civi_contact", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_civi_contact", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_civi_contact", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_civi_contact", ["language"], name: "language", using: :btree
  add_index "field_data_field_civi_contact", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_civicrm_group", id: false, force: :cascade do |t|
    t.string  "entity_type",               limit: 128, default: "", null: false
    t.string  "bundle",                    limit: 128, default: "", null: false
    t.integer "deleted",                   limit: 1,   default: 0,  null: false
    t.integer "entity_id",                 limit: 4,                null: false
    t.integer "revision_id",               limit: 4
    t.string  "language",                  limit: 32,  default: "", null: false
    t.integer "delta",                     limit: 4,                null: false
    t.integer "field_civicrm_group_value", limit: 4
  end

  add_index "field_data_field_civicrm_group", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_civicrm_group", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_civicrm_group", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_civicrm_group", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_civicrm_group", ["field_civicrm_group_value"], name: "field_civicrm_group_value", using: :btree
  add_index "field_data_field_civicrm_group", ["language"], name: "language", using: :btree
  add_index "field_data_field_civicrm_group", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_civicrm_multiday_session", id: false, force: :cascade do |t|
    t.string  "entity_type",                                limit: 128, default: "", null: false
    t.string  "bundle",                                     limit: 128, default: "", null: false
    t.integer "deleted",                                    limit: 1,   default: 0,  null: false
    t.integer "entity_id",                                  limit: 4,                null: false
    t.integer "revision_id",                                limit: 4
    t.string  "language",                                   limit: 32,  default: "", null: false
    t.integer "delta",                                      limit: 4,                null: false
    t.integer "field_civicrm_multiday_session_value",       limit: 4
    t.integer "field_civicrm_multiday_session_revision_id", limit: 4
  end

  add_index "field_data_field_civicrm_multiday_session", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_civicrm_multiday_session", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_civicrm_multiday_session", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_civicrm_multiday_session", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_civicrm_multiday_session", ["field_civicrm_multiday_session_revision_id"], name: "field_civicrm_multiday_session_revision_id", using: :btree
  add_index "field_data_field_civicrm_multiday_session", ["language"], name: "language", using: :btree
  add_index "field_data_field_civicrm_multiday_session", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_civicrm_multidayevent_type", id: false, force: :cascade do |t|
    t.string  "entity_type",                          limit: 128, default: "", null: false
    t.string  "bundle",                               limit: 128, default: "", null: false
    t.integer "deleted",                              limit: 1,   default: 0,  null: false
    t.integer "entity_id",                            limit: 4,                null: false
    t.integer "revision_id",                          limit: 4
    t.string  "language",                             limit: 32,  default: "", null: false
    t.integer "delta",                                limit: 4,                null: false
    t.integer "field_civicrm_multidayevent_type_tid", limit: 4
  end

  add_index "field_data_field_civicrm_multidayevent_type", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_civicrm_multidayevent_type", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_civicrm_multidayevent_type", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_civicrm_multidayevent_type", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_civicrm_multidayevent_type", ["field_civicrm_multidayevent_type_tid"], name: "field_civicrm_multidayevent_type_tid", using: :btree
  add_index "field_data_field_civicrm_multidayevent_type", ["language"], name: "language", using: :btree
  add_index "field_data_field_civicrm_multidayevent_type", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_civievent_id", id: false, force: :cascade do |t|
    t.string  "entity_type",              limit: 128, default: "", null: false
    t.string  "bundle",                   limit: 128, default: "", null: false
    t.integer "deleted",                  limit: 1,   default: 0,  null: false
    t.integer "entity_id",                limit: 4,                null: false
    t.integer "revision_id",              limit: 4
    t.string  "language",                 limit: 32,  default: "", null: false
    t.integer "delta",                    limit: 4,                null: false
    t.integer "field_civievent_id_value", limit: 4
  end

  add_index "field_data_field_civievent_id", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_civievent_id", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_civievent_id", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_civievent_id", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_civievent_id", ["language"], name: "language", using: :btree
  add_index "field_data_field_civievent_id", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_civievent_template", id: false, force: :cascade do |t|
    t.string  "entity_type",                    limit: 128, default: "", null: false
    t.string  "bundle",                         limit: 128, default: "", null: false
    t.integer "deleted",                        limit: 1,   default: 0,  null: false
    t.integer "entity_id",                      limit: 4,                null: false
    t.integer "revision_id",                    limit: 4
    t.string  "language",                       limit: 32,  default: "", null: false
    t.integer "delta",                          limit: 4,                null: false
    t.integer "field_civievent_template_value", limit: 4
  end

  add_index "field_data_field_civievent_template", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_civievent_template", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_civievent_template", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_civievent_template", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_civievent_template", ["field_civievent_template_value"], name: "field_civievent_template_value", using: :btree
  add_index "field_data_field_civievent_template", ["language"], name: "language", using: :btree
  add_index "field_data_field_civievent_template", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_crkids_checkin_child", id: false, force: :cascade do |t|
    t.string  "entity_type",                       limit: 128, default: "", null: false
    t.string  "bundle",                            limit: 128, default: "", null: false
    t.integer "deleted",                           limit: 1,   default: 0,  null: false
    t.integer "entity_id",                         limit: 4,                null: false
    t.integer "revision_id",                       limit: 4
    t.string  "language",                          limit: 32,  default: "", null: false
    t.integer "delta",                             limit: 4,                null: false
    t.string  "field_crkids_checkin_child_value",  limit: 255
    t.string  "field_crkids_checkin_child_format", limit: 255
  end

  add_index "field_data_field_crkids_checkin_child", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_crkids_checkin_child", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_crkids_checkin_child", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_crkids_checkin_child", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_crkids_checkin_child", ["field_crkids_checkin_child_format"], name: "field_crkids_checkin_child_format", using: :btree
  add_index "field_data_field_crkids_checkin_child", ["language"], name: "language", using: :btree
  add_index "field_data_field_crkids_checkin_child", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_crkids_checkin_classroom", id: false, force: :cascade do |t|
    t.string  "entity_type",                          limit: 128, default: "", null: false
    t.string  "bundle",                               limit: 128, default: "", null: false
    t.integer "deleted",                              limit: 1,   default: 0,  null: false
    t.integer "entity_id",                            limit: 4,                null: false
    t.integer "revision_id",                          limit: 4
    t.string  "language",                             limit: 32,  default: "", null: false
    t.integer "delta",                                limit: 4,                null: false
    t.string  "field_crkids_checkin_classroom_value", limit: 255
  end

  add_index "field_data_field_crkids_checkin_classroom", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_crkids_checkin_classroom", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_crkids_checkin_classroom", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_crkids_checkin_classroom", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_crkids_checkin_classroom", ["field_crkids_checkin_classroom_value"], name: "field_crkids_checkin_classroom_value", using: :btree
  add_index "field_data_field_crkids_checkin_classroom", ["language"], name: "language", using: :btree
  add_index "field_data_field_crkids_checkin_classroom", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_crkids_checkin_contact", id: false, force: :cascade do |t|
    t.string  "entity_type",                         limit: 128, default: "", null: false
    t.string  "bundle",                              limit: 128, default: "", null: false
    t.integer "deleted",                             limit: 1,   default: 0,  null: false
    t.integer "entity_id",                           limit: 4,                null: false
    t.integer "revision_id",                         limit: 4
    t.string  "language",                            limit: 32,  default: "", null: false
    t.integer "delta",                               limit: 4,                null: false
    t.string  "field_crkids_checkin_contact_value",  limit: 255
    t.string  "field_crkids_checkin_contact_format", limit: 255
  end

  add_index "field_data_field_crkids_checkin_contact", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_crkids_checkin_contact", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_crkids_checkin_contact", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_crkids_checkin_contact", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_crkids_checkin_contact", ["field_crkids_checkin_contact_format"], name: "field_crkids_checkin_contact_format", using: :btree
  add_index "field_data_field_crkids_checkin_contact", ["language"], name: "language", using: :btree
  add_index "field_data_field_crkids_checkin_contact", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_crkids_checkin_date", id: false, force: :cascade do |t|
    t.string   "entity_type",                     limit: 128, default: "", null: false
    t.string   "bundle",                          limit: 128, default: "", null: false
    t.integer  "deleted",                         limit: 1,   default: 0,  null: false
    t.integer  "entity_id",                       limit: 4,                null: false
    t.integer  "revision_id",                     limit: 4
    t.string   "language",                        limit: 32,  default: "", null: false
    t.integer  "delta",                           limit: 4,                null: false
    t.datetime "field_crkids_checkin_date_value"
  end

  add_index "field_data_field_crkids_checkin_date", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_crkids_checkin_date", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_crkids_checkin_date", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_crkids_checkin_date", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_crkids_checkin_date", ["language"], name: "language", using: :btree
  add_index "field_data_field_crkids_checkin_date", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_crkids_checkin_notes", id: false, force: :cascade do |t|
    t.string  "entity_type",                       limit: 128,        default: "", null: false
    t.string  "bundle",                            limit: 128,        default: "", null: false
    t.integer "deleted",                           limit: 1,          default: 0,  null: false
    t.integer "entity_id",                         limit: 4,                       null: false
    t.integer "revision_id",                       limit: 4
    t.string  "language",                          limit: 32,         default: "", null: false
    t.integer "delta",                             limit: 4,                       null: false
    t.text    "field_crkids_checkin_notes_value",  limit: 4294967295
    t.string  "field_crkids_checkin_notes_format", limit: 255
  end

  add_index "field_data_field_crkids_checkin_notes", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_crkids_checkin_notes", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_crkids_checkin_notes", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_crkids_checkin_notes", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_crkids_checkin_notes", ["field_crkids_checkin_notes_format"], name: "field_crkids_checkin_notes_format", using: :btree
  add_index "field_data_field_crkids_checkin_notes", ["language"], name: "language", using: :btree
  add_index "field_data_field_crkids_checkin_notes", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_crkids_checkin_type", id: false, force: :cascade do |t|
    t.string  "entity_type",                     limit: 128, default: "", null: false
    t.string  "bundle",                          limit: 128, default: "", null: false
    t.integer "deleted",                         limit: 1,   default: 0,  null: false
    t.integer "entity_id",                       limit: 4,                null: false
    t.integer "revision_id",                     limit: 4
    t.string  "language",                        limit: 32,  default: "", null: false
    t.integer "delta",                           limit: 4,                null: false
    t.string  "field_crkids_checkin_type_value", limit: 255
  end

  add_index "field_data_field_crkids_checkin_type", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_crkids_checkin_type", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_crkids_checkin_type", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_crkids_checkin_type", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_crkids_checkin_type", ["field_crkids_checkin_type_value"], name: "field_crkids_checkin_type_value", using: :btree
  add_index "field_data_field_crkids_checkin_type", ["language"], name: "language", using: :btree
  add_index "field_data_field_crkids_checkin_type", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_date_of_first_session", id: false, force: :cascade do |t|
    t.string   "entity_type",                       limit: 128, default: "", null: false
    t.string   "bundle",                            limit: 128, default: "", null: false
    t.integer  "deleted",                           limit: 1,   default: 0,  null: false
    t.integer  "entity_id",                         limit: 4,                null: false
    t.integer  "revision_id",                       limit: 4
    t.string   "language",                          limit: 32,  default: "", null: false
    t.integer  "delta",                             limit: 4,                null: false
    t.datetime "field_date_of_first_session_value"
  end

  add_index "field_data_field_date_of_first_session", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_date_of_first_session", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_date_of_first_session", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_date_of_first_session", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_date_of_first_session", ["language"], name: "language", using: :btree
  add_index "field_data_field_date_of_first_session", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_image", id: false, force: :cascade do |t|
    t.string  "entity_type",        limit: 128,  default: "", null: false
    t.string  "bundle",             limit: 128,  default: "", null: false
    t.integer "deleted",            limit: 1,    default: 0,  null: false
    t.integer "entity_id",          limit: 4,                 null: false
    t.integer "revision_id",        limit: 4
    t.string  "language",           limit: 32,   default: "", null: false
    t.integer "delta",              limit: 4,                 null: false
    t.integer "field_image_fid",    limit: 4
    t.string  "field_image_alt",    limit: 512
    t.string  "field_image_title",  limit: 1024
    t.integer "field_image_width",  limit: 4
    t.integer "field_image_height", limit: 4
  end

  add_index "field_data_field_image", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_image", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_image", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_image", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_image", ["field_image_fid"], name: "field_image_fid", using: :btree
  add_index "field_data_field_image", ["language"], name: "language", using: :btree
  add_index "field_data_field_image", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_session_date", id: false, force: :cascade do |t|
    t.string   "entity_type",               limit: 128, default: "", null: false
    t.string   "bundle",                    limit: 128, default: "", null: false
    t.integer  "deleted",                   limit: 1,   default: 0,  null: false
    t.integer  "entity_id",                 limit: 4,                null: false
    t.integer  "revision_id",               limit: 4
    t.string   "language",                  limit: 32,  default: "", null: false
    t.integer  "delta",                     limit: 4,                null: false
    t.datetime "field_session_date_value"
    t.datetime "field_session_date_value2"
  end

  add_index "field_data_field_session_date", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_session_date", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_session_date", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_session_date", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_session_date", ["language"], name: "language", using: :btree
  add_index "field_data_field_session_date", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_field_tags", id: false, force: :cascade do |t|
    t.string  "entity_type",    limit: 128, default: "", null: false
    t.string  "bundle",         limit: 128, default: "", null: false
    t.integer "deleted",        limit: 1,   default: 0,  null: false
    t.integer "entity_id",      limit: 4,                null: false
    t.integer "revision_id",    limit: 4
    t.string  "language",       limit: 32,  default: "", null: false
    t.integer "delta",          limit: 4,                null: false
    t.integer "field_tags_tid", limit: 4
  end

  add_index "field_data_field_tags", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_field_tags", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_field_tags", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_field_tags", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_field_tags", ["field_tags_tid"], name: "field_tags_tid", using: :btree
  add_index "field_data_field_tags", ["language"], name: "language", using: :btree
  add_index "field_data_field_tags", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_data_uc_product_image", id: false, force: :cascade do |t|
    t.string  "entity_type",             limit: 128,  default: "", null: false
    t.string  "bundle",                  limit: 128,  default: "", null: false
    t.integer "deleted",                 limit: 1,    default: 0,  null: false
    t.integer "entity_id",               limit: 4,                 null: false
    t.integer "revision_id",             limit: 4
    t.string  "language",                limit: 32,   default: "", null: false
    t.integer "delta",                   limit: 4,                 null: false
    t.integer "uc_product_image_fid",    limit: 4
    t.string  "uc_product_image_alt",    limit: 512
    t.string  "uc_product_image_title",  limit: 1024
    t.integer "uc_product_image_width",  limit: 4
    t.integer "uc_product_image_height", limit: 4
  end

  add_index "field_data_uc_product_image", ["bundle"], name: "bundle", using: :btree
  add_index "field_data_uc_product_image", ["deleted"], name: "deleted", using: :btree
  add_index "field_data_uc_product_image", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_data_uc_product_image", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_data_uc_product_image", ["language"], name: "language", using: :btree
  add_index "field_data_uc_product_image", ["revision_id"], name: "revision_id", using: :btree
  add_index "field_data_uc_product_image", ["uc_product_image_fid"], name: "uc_product_image_fid", using: :btree

  create_table "field_revision_body", id: false, force: :cascade do |t|
    t.string  "entity_type",  limit: 128,        default: "", null: false
    t.string  "bundle",       limit: 128,        default: "", null: false
    t.integer "deleted",      limit: 1,          default: 0,  null: false
    t.integer "entity_id",    limit: 4,                       null: false
    t.integer "revision_id",  limit: 4,                       null: false
    t.string  "language",     limit: 32,         default: "", null: false
    t.integer "delta",        limit: 4,                       null: false
    t.text    "body_value",   limit: 4294967295
    t.text    "body_summary", limit: 4294967295
    t.string  "body_format",  limit: 255
  end

  add_index "field_revision_body", ["body_format"], name: "body_format", using: :btree
  add_index "field_revision_body", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_body", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_body", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_body", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_body", ["language"], name: "language", using: :btree
  add_index "field_revision_body", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_comment_body", id: false, force: :cascade do |t|
    t.string  "entity_type",         limit: 128,        default: "", null: false
    t.string  "bundle",              limit: 128,        default: "", null: false
    t.integer "deleted",             limit: 1,          default: 0,  null: false
    t.integer "entity_id",           limit: 4,                       null: false
    t.integer "revision_id",         limit: 4,                       null: false
    t.string  "language",            limit: 32,         default: "", null: false
    t.integer "delta",               limit: 4,                       null: false
    t.text    "comment_body_value",  limit: 4294967295
    t.string  "comment_body_format", limit: 255
  end

  add_index "field_revision_comment_body", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_comment_body", ["comment_body_format"], name: "comment_body_format", using: :btree
  add_index "field_revision_comment_body", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_comment_body", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_comment_body", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_comment_body", ["language"], name: "language", using: :btree
  add_index "field_revision_comment_body", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_barcode", id: false, force: :cascade do |t|
    t.string  "entity_type",         limit: 128, default: "", null: false
    t.string  "bundle",              limit: 128, default: "", null: false
    t.integer "deleted",             limit: 1,   default: 0,  null: false
    t.integer "entity_id",           limit: 4,                null: false
    t.integer "revision_id",         limit: 4,                null: false
    t.string  "language",            limit: 32,  default: "", null: false
    t.integer "delta",               limit: 4,                null: false
    t.string  "field_barcode_value", limit: 255
  end

  add_index "field_revision_field_barcode", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_barcode", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_barcode", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_barcode", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_barcode", ["language"], name: "language", using: :btree
  add_index "field_revision_field_barcode", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_civi_contact", id: false, force: :cascade do |t|
    t.string  "entity_type",                   limit: 128, default: "", null: false
    t.string  "bundle",                        limit: 128, default: "", null: false
    t.integer "deleted",                       limit: 1,   default: 0,  null: false
    t.integer "entity_id",                     limit: 4,                null: false
    t.integer "revision_id",                   limit: 4,                null: false
    t.string  "language",                      limit: 32,  default: "", null: false
    t.integer "delta",                         limit: 4,                null: false
    t.integer "field_civi_contact_contact_id", limit: 4
  end

  add_index "field_revision_field_civi_contact", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_civi_contact", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_civi_contact", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_civi_contact", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_civi_contact", ["language"], name: "language", using: :btree
  add_index "field_revision_field_civi_contact", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_civicrm_group", id: false, force: :cascade do |t|
    t.string  "entity_type",               limit: 128, default: "", null: false
    t.string  "bundle",                    limit: 128, default: "", null: false
    t.integer "deleted",                   limit: 1,   default: 0,  null: false
    t.integer "entity_id",                 limit: 4,                null: false
    t.integer "revision_id",               limit: 4,                null: false
    t.string  "language",                  limit: 32,  default: "", null: false
    t.integer "delta",                     limit: 4,                null: false
    t.integer "field_civicrm_group_value", limit: 4
  end

  add_index "field_revision_field_civicrm_group", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_civicrm_group", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_civicrm_group", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_civicrm_group", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_civicrm_group", ["field_civicrm_group_value"], name: "field_civicrm_group_value", using: :btree
  add_index "field_revision_field_civicrm_group", ["language"], name: "language", using: :btree
  add_index "field_revision_field_civicrm_group", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_civicrm_multiday_session", id: false, force: :cascade do |t|
    t.string  "entity_type",                                limit: 128, default: "", null: false
    t.string  "bundle",                                     limit: 128, default: "", null: false
    t.integer "deleted",                                    limit: 1,   default: 0,  null: false
    t.integer "entity_id",                                  limit: 4,                null: false
    t.integer "revision_id",                                limit: 4,                null: false
    t.string  "language",                                   limit: 32,  default: "", null: false
    t.integer "delta",                                      limit: 4,                null: false
    t.integer "field_civicrm_multiday_session_value",       limit: 4
    t.integer "field_civicrm_multiday_session_revision_id", limit: 4
  end

  add_index "field_revision_field_civicrm_multiday_session", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_civicrm_multiday_session", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_civicrm_multiday_session", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_civicrm_multiday_session", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_civicrm_multiday_session", ["field_civicrm_multiday_session_revision_id"], name: "field_civicrm_multiday_session_revision_id", using: :btree
  add_index "field_revision_field_civicrm_multiday_session", ["language"], name: "language", using: :btree
  add_index "field_revision_field_civicrm_multiday_session", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_civicrm_multidayevent_type", id: false, force: :cascade do |t|
    t.string  "entity_type",                          limit: 128, default: "", null: false
    t.string  "bundle",                               limit: 128, default: "", null: false
    t.integer "deleted",                              limit: 1,   default: 0,  null: false
    t.integer "entity_id",                            limit: 4,                null: false
    t.integer "revision_id",                          limit: 4,                null: false
    t.string  "language",                             limit: 32,  default: "", null: false
    t.integer "delta",                                limit: 4,                null: false
    t.integer "field_civicrm_multidayevent_type_tid", limit: 4
  end

  add_index "field_revision_field_civicrm_multidayevent_type", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_civicrm_multidayevent_type", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_civicrm_multidayevent_type", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_civicrm_multidayevent_type", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_civicrm_multidayevent_type", ["field_civicrm_multidayevent_type_tid"], name: "field_civicrm_multidayevent_type_tid", using: :btree
  add_index "field_revision_field_civicrm_multidayevent_type", ["language"], name: "language", using: :btree
  add_index "field_revision_field_civicrm_multidayevent_type", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_civievent_id", id: false, force: :cascade do |t|
    t.string  "entity_type",              limit: 128, default: "", null: false
    t.string  "bundle",                   limit: 128, default: "", null: false
    t.integer "deleted",                  limit: 1,   default: 0,  null: false
    t.integer "entity_id",                limit: 4,                null: false
    t.integer "revision_id",              limit: 4,                null: false
    t.string  "language",                 limit: 32,  default: "", null: false
    t.integer "delta",                    limit: 4,                null: false
    t.integer "field_civievent_id_value", limit: 4
  end

  add_index "field_revision_field_civievent_id", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_civievent_id", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_civievent_id", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_civievent_id", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_civievent_id", ["language"], name: "language", using: :btree
  add_index "field_revision_field_civievent_id", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_civievent_template", id: false, force: :cascade do |t|
    t.string  "entity_type",                    limit: 128, default: "", null: false
    t.string  "bundle",                         limit: 128, default: "", null: false
    t.integer "deleted",                        limit: 1,   default: 0,  null: false
    t.integer "entity_id",                      limit: 4,                null: false
    t.integer "revision_id",                    limit: 4,                null: false
    t.string  "language",                       limit: 32,  default: "", null: false
    t.integer "delta",                          limit: 4,                null: false
    t.integer "field_civievent_template_value", limit: 4
  end

  add_index "field_revision_field_civievent_template", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_civievent_template", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_civievent_template", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_civievent_template", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_civievent_template", ["field_civievent_template_value"], name: "field_civievent_template_value", using: :btree
  add_index "field_revision_field_civievent_template", ["language"], name: "language", using: :btree
  add_index "field_revision_field_civievent_template", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_crkids_checkin_child", id: false, force: :cascade do |t|
    t.string  "entity_type",                       limit: 128, default: "", null: false
    t.string  "bundle",                            limit: 128, default: "", null: false
    t.integer "deleted",                           limit: 1,   default: 0,  null: false
    t.integer "entity_id",                         limit: 4,                null: false
    t.integer "revision_id",                       limit: 4,                null: false
    t.string  "language",                          limit: 32,  default: "", null: false
    t.integer "delta",                             limit: 4,                null: false
    t.string  "field_crkids_checkin_child_value",  limit: 255
    t.string  "field_crkids_checkin_child_format", limit: 255
  end

  add_index "field_revision_field_crkids_checkin_child", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_crkids_checkin_child", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_crkids_checkin_child", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_crkids_checkin_child", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_crkids_checkin_child", ["field_crkids_checkin_child_format"], name: "field_crkids_checkin_child_format", using: :btree
  add_index "field_revision_field_crkids_checkin_child", ["language"], name: "language", using: :btree
  add_index "field_revision_field_crkids_checkin_child", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_crkids_checkin_classroom", id: false, force: :cascade do |t|
    t.string  "entity_type",                          limit: 128, default: "", null: false
    t.string  "bundle",                               limit: 128, default: "", null: false
    t.integer "deleted",                              limit: 1,   default: 0,  null: false
    t.integer "entity_id",                            limit: 4,                null: false
    t.integer "revision_id",                          limit: 4,                null: false
    t.string  "language",                             limit: 32,  default: "", null: false
    t.integer "delta",                                limit: 4,                null: false
    t.string  "field_crkids_checkin_classroom_value", limit: 255
  end

  add_index "field_revision_field_crkids_checkin_classroom", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_crkids_checkin_classroom", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_crkids_checkin_classroom", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_crkids_checkin_classroom", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_crkids_checkin_classroom", ["field_crkids_checkin_classroom_value"], name: "field_crkids_checkin_classroom_value", using: :btree
  add_index "field_revision_field_crkids_checkin_classroom", ["language"], name: "language", using: :btree
  add_index "field_revision_field_crkids_checkin_classroom", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_crkids_checkin_contact", id: false, force: :cascade do |t|
    t.string  "entity_type",                         limit: 128, default: "", null: false
    t.string  "bundle",                              limit: 128, default: "", null: false
    t.integer "deleted",                             limit: 1,   default: 0,  null: false
    t.integer "entity_id",                           limit: 4,                null: false
    t.integer "revision_id",                         limit: 4,                null: false
    t.string  "language",                            limit: 32,  default: "", null: false
    t.integer "delta",                               limit: 4,                null: false
    t.string  "field_crkids_checkin_contact_value",  limit: 255
    t.string  "field_crkids_checkin_contact_format", limit: 255
  end

  add_index "field_revision_field_crkids_checkin_contact", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_crkids_checkin_contact", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_crkids_checkin_contact", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_crkids_checkin_contact", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_crkids_checkin_contact", ["field_crkids_checkin_contact_format"], name: "field_crkids_checkin_contact_format", using: :btree
  add_index "field_revision_field_crkids_checkin_contact", ["language"], name: "language", using: :btree
  add_index "field_revision_field_crkids_checkin_contact", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_crkids_checkin_date", id: false, force: :cascade do |t|
    t.string   "entity_type",                     limit: 128, default: "", null: false
    t.string   "bundle",                          limit: 128, default: "", null: false
    t.integer  "deleted",                         limit: 1,   default: 0,  null: false
    t.integer  "entity_id",                       limit: 4,                null: false
    t.integer  "revision_id",                     limit: 4,                null: false
    t.string   "language",                        limit: 32,  default: "", null: false
    t.integer  "delta",                           limit: 4,                null: false
    t.datetime "field_crkids_checkin_date_value"
  end

  add_index "field_revision_field_crkids_checkin_date", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_crkids_checkin_date", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_crkids_checkin_date", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_crkids_checkin_date", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_crkids_checkin_date", ["language"], name: "language", using: :btree
  add_index "field_revision_field_crkids_checkin_date", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_crkids_checkin_notes", id: false, force: :cascade do |t|
    t.string  "entity_type",                       limit: 128,        default: "", null: false
    t.string  "bundle",                            limit: 128,        default: "", null: false
    t.integer "deleted",                           limit: 1,          default: 0,  null: false
    t.integer "entity_id",                         limit: 4,                       null: false
    t.integer "revision_id",                       limit: 4,                       null: false
    t.string  "language",                          limit: 32,         default: "", null: false
    t.integer "delta",                             limit: 4,                       null: false
    t.text    "field_crkids_checkin_notes_value",  limit: 4294967295
    t.string  "field_crkids_checkin_notes_format", limit: 255
  end

  add_index "field_revision_field_crkids_checkin_notes", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_crkids_checkin_notes", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_crkids_checkin_notes", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_crkids_checkin_notes", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_crkids_checkin_notes", ["field_crkids_checkin_notes_format"], name: "field_crkids_checkin_notes_format", using: :btree
  add_index "field_revision_field_crkids_checkin_notes", ["language"], name: "language", using: :btree
  add_index "field_revision_field_crkids_checkin_notes", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_crkids_checkin_type", id: false, force: :cascade do |t|
    t.string  "entity_type",                     limit: 128, default: "", null: false
    t.string  "bundle",                          limit: 128, default: "", null: false
    t.integer "deleted",                         limit: 1,   default: 0,  null: false
    t.integer "entity_id",                       limit: 4,                null: false
    t.integer "revision_id",                     limit: 4,                null: false
    t.string  "language",                        limit: 32,  default: "", null: false
    t.integer "delta",                           limit: 4,                null: false
    t.string  "field_crkids_checkin_type_value", limit: 255
  end

  add_index "field_revision_field_crkids_checkin_type", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_crkids_checkin_type", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_crkids_checkin_type", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_crkids_checkin_type", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_crkids_checkin_type", ["field_crkids_checkin_type_value"], name: "field_crkids_checkin_type_value", using: :btree
  add_index "field_revision_field_crkids_checkin_type", ["language"], name: "language", using: :btree
  add_index "field_revision_field_crkids_checkin_type", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_date_of_first_session", id: false, force: :cascade do |t|
    t.string   "entity_type",                       limit: 128, default: "", null: false
    t.string   "bundle",                            limit: 128, default: "", null: false
    t.integer  "deleted",                           limit: 1,   default: 0,  null: false
    t.integer  "entity_id",                         limit: 4,                null: false
    t.integer  "revision_id",                       limit: 4,                null: false
    t.string   "language",                          limit: 32,  default: "", null: false
    t.integer  "delta",                             limit: 4,                null: false
    t.datetime "field_date_of_first_session_value"
  end

  add_index "field_revision_field_date_of_first_session", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_date_of_first_session", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_date_of_first_session", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_date_of_first_session", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_date_of_first_session", ["language"], name: "language", using: :btree
  add_index "field_revision_field_date_of_first_session", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_image", id: false, force: :cascade do |t|
    t.string  "entity_type",        limit: 128,  default: "", null: false
    t.string  "bundle",             limit: 128,  default: "", null: false
    t.integer "deleted",            limit: 1,    default: 0,  null: false
    t.integer "entity_id",          limit: 4,                 null: false
    t.integer "revision_id",        limit: 4,                 null: false
    t.string  "language",           limit: 32,   default: "", null: false
    t.integer "delta",              limit: 4,                 null: false
    t.integer "field_image_fid",    limit: 4
    t.string  "field_image_alt",    limit: 512
    t.string  "field_image_title",  limit: 1024
    t.integer "field_image_width",  limit: 4
    t.integer "field_image_height", limit: 4
  end

  add_index "field_revision_field_image", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_image", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_image", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_image", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_image", ["field_image_fid"], name: "field_image_fid", using: :btree
  add_index "field_revision_field_image", ["language"], name: "language", using: :btree
  add_index "field_revision_field_image", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_session_date", id: false, force: :cascade do |t|
    t.string   "entity_type",               limit: 128, default: "", null: false
    t.string   "bundle",                    limit: 128, default: "", null: false
    t.integer  "deleted",                   limit: 1,   default: 0,  null: false
    t.integer  "entity_id",                 limit: 4,                null: false
    t.integer  "revision_id",               limit: 4,                null: false
    t.string   "language",                  limit: 32,  default: "", null: false
    t.integer  "delta",                     limit: 4,                null: false
    t.datetime "field_session_date_value"
    t.datetime "field_session_date_value2"
  end

  add_index "field_revision_field_session_date", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_session_date", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_session_date", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_session_date", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_session_date", ["language"], name: "language", using: :btree
  add_index "field_revision_field_session_date", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_field_tags", id: false, force: :cascade do |t|
    t.string  "entity_type",    limit: 128, default: "", null: false
    t.string  "bundle",         limit: 128, default: "", null: false
    t.integer "deleted",        limit: 1,   default: 0,  null: false
    t.integer "entity_id",      limit: 4,                null: false
    t.integer "revision_id",    limit: 4,                null: false
    t.string  "language",       limit: 32,  default: "", null: false
    t.integer "delta",          limit: 4,                null: false
    t.integer "field_tags_tid", limit: 4
  end

  add_index "field_revision_field_tags", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_field_tags", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_field_tags", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_field_tags", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_field_tags", ["field_tags_tid"], name: "field_tags_tid", using: :btree
  add_index "field_revision_field_tags", ["language"], name: "language", using: :btree
  add_index "field_revision_field_tags", ["revision_id"], name: "revision_id", using: :btree

  create_table "field_revision_uc_product_image", id: false, force: :cascade do |t|
    t.string  "entity_type",             limit: 128,  default: "", null: false
    t.string  "bundle",                  limit: 128,  default: "", null: false
    t.integer "deleted",                 limit: 1,    default: 0,  null: false
    t.integer "entity_id",               limit: 4,                 null: false
    t.integer "revision_id",             limit: 4,                 null: false
    t.string  "language",                limit: 32,   default: "", null: false
    t.integer "delta",                   limit: 4,                 null: false
    t.integer "uc_product_image_fid",    limit: 4
    t.string  "uc_product_image_alt",    limit: 512
    t.string  "uc_product_image_title",  limit: 1024
    t.integer "uc_product_image_width",  limit: 4
    t.integer "uc_product_image_height", limit: 4
  end

  add_index "field_revision_uc_product_image", ["bundle"], name: "bundle", using: :btree
  add_index "field_revision_uc_product_image", ["deleted"], name: "deleted", using: :btree
  add_index "field_revision_uc_product_image", ["entity_id"], name: "entity_id", using: :btree
  add_index "field_revision_uc_product_image", ["entity_type"], name: "entity_type", using: :btree
  add_index "field_revision_uc_product_image", ["language"], name: "language", using: :btree
  add_index "field_revision_uc_product_image", ["revision_id"], name: "revision_id", using: :btree
  add_index "field_revision_uc_product_image", ["uc_product_image_fid"], name: "uc_product_image_fid", using: :btree

  create_table "file_managed", primary_key: "fid", force: :cascade do |t|
    t.integer "uid",       limit: 4,   default: 0,  null: false
    t.string  "filename",  limit: 255, default: "", null: false
    t.string  "uri",       limit: 255, default: "", null: false
    t.string  "filemime",  limit: 255, default: "", null: false
    t.integer "filesize",  limit: 8,   default: 0,  null: false
    t.integer "status",    limit: 1,   default: 0,  null: false
    t.integer "timestamp", limit: 4,   default: 0,  null: false
  end

  add_index "file_managed", ["status"], name: "status", using: :btree
  add_index "file_managed", ["timestamp"], name: "timestamp", using: :btree
  add_index "file_managed", ["uid"], name: "uid", using: :btree
  add_index "file_managed", ["uri"], name: "uri", unique: true, using: :btree

  create_table "file_usage", id: false, force: :cascade do |t|
    t.integer "fid",    limit: 4,                null: false
    t.string  "module", limit: 255, default: "", null: false
    t.string  "type",   limit: 64,  default: "", null: false
    t.integer "id",     limit: 4,   default: 0,  null: false
    t.integer "count",  limit: 4,   default: 0,  null: false
  end

  add_index "file_usage", ["fid", "count"], name: "fid_count", using: :btree
  add_index "file_usage", ["fid", "module"], name: "fid_module", using: :btree
  add_index "file_usage", ["type", "id"], name: "type_id", using: :btree

  create_table "filter", id: false, force: :cascade do |t|
    t.string  "format",   limit: 255,                     null: false
    t.string  "module",   limit: 64,         default: "", null: false
    t.string  "name",     limit: 32,         default: "", null: false
    t.integer "weight",   limit: 4,          default: 0,  null: false
    t.integer "status",   limit: 4,          default: 0,  null: false
    t.binary  "settings", limit: 4294967295
  end

  add_index "filter", ["weight", "module", "name"], name: "list", using: :btree

  create_table "filter_format", primary_key: "format", force: :cascade do |t|
    t.string  "name",   limit: 255, default: "", null: false
    t.integer "cache",  limit: 1,   default: 0,  null: false
    t.integer "status", limit: 1,   default: 1,  null: false
    t.integer "weight", limit: 4,   default: 0,  null: false
  end

  add_index "filter_format", ["name"], name: "name", unique: true, using: :btree
  add_index "filter_format", ["status", "weight"], name: "status_weight", using: :btree

  create_table "flood", primary_key: "fid", force: :cascade do |t|
    t.string  "event",      limit: 64,  default: "", null: false
    t.string  "identifier", limit: 128, default: "", null: false
    t.integer "timestamp",  limit: 4,   default: 0,  null: false
    t.integer "expiration", limit: 4,   default: 0,  null: false
  end

  add_index "flood", ["event", "identifier", "timestamp"], name: "allow", using: :btree
  add_index "flood", ["expiration"], name: "purge", using: :btree

  create_table "history", id: false, force: :cascade do |t|
    t.integer "uid",       limit: 4, default: 0, null: false
    t.integer "nid",       limit: 4, default: 0, null: false
    t.integer "timestamp", limit: 4, default: 0, null: false
  end

  add_index "history", ["nid"], name: "nid", using: :btree

  create_table "image_effects", primary_key: "ieid", force: :cascade do |t|
    t.integer "isid",   limit: 4,          default: 0, null: false
    t.integer "weight", limit: 4,          default: 0, null: false
    t.string  "name",   limit: 255,                    null: false
    t.binary  "data",   limit: 4294967295,             null: false
  end

  add_index "image_effects", ["isid"], name: "isid", using: :btree
  add_index "image_effects", ["weight"], name: "weight", using: :btree

  create_table "image_styles", primary_key: "isid", force: :cascade do |t|
    t.string "name",  limit: 255,              null: false
    t.string "label", limit: 255, default: "", null: false
  end

  add_index "image_styles", ["name"], name: "name", unique: true, using: :btree

  create_table "menu_custom", primary_key: "menu_name", force: :cascade do |t|
    t.string "title",       limit: 255,   default: "", null: false
    t.text   "description", limit: 65535
  end

  create_table "menu_links", primary_key: "mlid", force: :cascade do |t|
    t.string  "menu_name",    limit: 32,    default: "",       null: false
    t.integer "plid",         limit: 4,     default: 0,        null: false
    t.string  "link_path",    limit: 255,   default: "",       null: false
    t.string  "router_path",  limit: 255,   default: "",       null: false
    t.string  "link_title",   limit: 255,   default: "",       null: false
    t.binary  "options",      limit: 65535
    t.string  "module",       limit: 255,   default: "system", null: false
    t.integer "hidden",       limit: 2,     default: 0,        null: false
    t.integer "external",     limit: 2,     default: 0,        null: false
    t.integer "has_children", limit: 2,     default: 0,        null: false
    t.integer "expanded",     limit: 2,     default: 0,        null: false
    t.integer "weight",       limit: 4,     default: 0,        null: false
    t.integer "depth",        limit: 2,     default: 0,        null: false
    t.integer "customized",   limit: 2,     default: 0,        null: false
    t.integer "p1",           limit: 4,     default: 0,        null: false
    t.integer "p2",           limit: 4,     default: 0,        null: false
    t.integer "p3",           limit: 4,     default: 0,        null: false
    t.integer "p4",           limit: 4,     default: 0,        null: false
    t.integer "p5",           limit: 4,     default: 0,        null: false
    t.integer "p6",           limit: 4,     default: 0,        null: false
    t.integer "p7",           limit: 4,     default: 0,        null: false
    t.integer "p8",           limit: 4,     default: 0,        null: false
    t.integer "p9",           limit: 4,     default: 0,        null: false
    t.integer "updated",      limit: 2,     default: 0,        null: false
  end

  add_index "menu_links", ["link_path", "menu_name"], name: "path_menu", length: {"link_path"=>128, "menu_name"=>nil}, using: :btree
  add_index "menu_links", ["menu_name", "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9"], name: "menu_parents", using: :btree
  add_index "menu_links", ["menu_name", "plid", "expanded", "has_children"], name: "menu_plid_expand_child", using: :btree
  add_index "menu_links", ["router_path"], name: "router_path", length: {"router_path"=>128}, using: :btree

  create_table "menu_router", primary_key: "path", force: :cascade do |t|
    t.binary  "load_functions",    limit: 65535,                 null: false
    t.binary  "to_arg_functions",  limit: 65535,                 null: false
    t.string  "access_callback",   limit: 255,      default: "", null: false
    t.binary  "access_arguments",  limit: 65535
    t.string  "page_callback",     limit: 255,      default: "", null: false
    t.binary  "page_arguments",    limit: 65535
    t.string  "delivery_callback", limit: 255,      default: "", null: false
    t.integer "fit",               limit: 4,        default: 0,  null: false
    t.integer "number_parts",      limit: 2,        default: 0,  null: false
    t.integer "context",           limit: 4,        default: 0,  null: false
    t.string  "tab_parent",        limit: 255,      default: "", null: false
    t.string  "tab_root",          limit: 255,      default: "", null: false
    t.string  "title",             limit: 255,      default: "", null: false
    t.string  "title_callback",    limit: 255,      default: "", null: false
    t.string  "title_arguments",   limit: 255,      default: "", null: false
    t.string  "theme_callback",    limit: 255,      default: "", null: false
    t.string  "theme_arguments",   limit: 255,      default: "", null: false
    t.integer "type",              limit: 4,        default: 0,  null: false
    t.text    "description",       limit: 65535,                 null: false
    t.string  "position",          limit: 255,      default: "", null: false
    t.integer "weight",            limit: 4,        default: 0,  null: false
    t.text    "include_file",      limit: 16777215
  end

  add_index "menu_router", ["fit"], name: "fit", using: :btree
  add_index "menu_router", ["tab_parent", "weight", "title"], name: "tab_parent", length: {"tab_parent"=>64, "weight"=>nil, "title"=>nil}, using: :btree
  add_index "menu_router", ["tab_root", "weight", "title"], name: "tab_root_weight_title", length: {"tab_root"=>64, "weight"=>nil, "title"=>nil}, using: :btree

  create_table "node", primary_key: "nid", force: :cascade do |t|
    t.integer "vid",       limit: 4
    t.string  "type",      limit: 32,  default: "", null: false
    t.string  "language",  limit: 12,  default: "", null: false
    t.string  "title",     limit: 255, default: "", null: false
    t.integer "uid",       limit: 4,   default: 0,  null: false
    t.integer "status",    limit: 4,   default: 1,  null: false
    t.integer "created",   limit: 4,   default: 0,  null: false
    t.integer "changed",   limit: 4,   default: 0,  null: false
    t.integer "comment",   limit: 4,   default: 0,  null: false
    t.integer "promote",   limit: 4,   default: 0,  null: false
    t.integer "sticky",    limit: 4,   default: 0,  null: false
    t.integer "tnid",      limit: 4,   default: 0,  null: false
    t.integer "translate", limit: 4,   default: 0,  null: false
  end

  add_index "node", ["changed"], name: "node_changed", using: :btree
  add_index "node", ["created"], name: "node_created", using: :btree
  add_index "node", ["language"], name: "language", using: :btree
  add_index "node", ["promote", "status", "sticky", "created"], name: "node_frontpage", using: :btree
  add_index "node", ["status", "type", "nid"], name: "node_status_type", using: :btree
  add_index "node", ["title", "type"], name: "node_title_type", length: {"title"=>nil, "type"=>4}, using: :btree
  add_index "node", ["tnid"], name: "tnid", using: :btree
  add_index "node", ["translate"], name: "translate", using: :btree
  add_index "node", ["type"], name: "node_type", length: {"type"=>4}, using: :btree
  add_index "node", ["uid"], name: "uid", using: :btree
  add_index "node", ["vid"], name: "vid", unique: true, using: :btree

  create_table "node_access", id: false, force: :cascade do |t|
    t.integer "nid",          limit: 4,   default: 0,  null: false
    t.integer "gid",          limit: 4,   default: 0,  null: false
    t.string  "realm",        limit: 255, default: "", null: false
    t.integer "grant_view",   limit: 1,   default: 0,  null: false
    t.integer "grant_update", limit: 1,   default: 0,  null: false
    t.integer "grant_delete", limit: 1,   default: 0,  null: false
  end

  create_table "node_comment_statistics", primary_key: "nid", force: :cascade do |t|
    t.integer "cid",                    limit: 4,  default: 0, null: false
    t.integer "last_comment_timestamp", limit: 4,  default: 0, null: false
    t.string  "last_comment_name",      limit: 60
    t.integer "last_comment_uid",       limit: 4,  default: 0, null: false
    t.integer "comment_count",          limit: 4,  default: 0, null: false
  end

  add_index "node_comment_statistics", ["comment_count"], name: "comment_count", using: :btree
  add_index "node_comment_statistics", ["last_comment_timestamp"], name: "node_comment_timestamp", using: :btree
  add_index "node_comment_statistics", ["last_comment_uid"], name: "last_comment_uid", using: :btree

  create_table "node_revision", primary_key: "vid", force: :cascade do |t|
    t.integer "nid",       limit: 4,          default: 0,  null: false
    t.integer "uid",       limit: 4,          default: 0,  null: false
    t.string  "title",     limit: 255,        default: "", null: false
    t.text    "log",       limit: 4294967295,              null: false
    t.integer "timestamp", limit: 4,          default: 0,  null: false
    t.integer "status",    limit: 4,          default: 1,  null: false
    t.integer "comment",   limit: 4,          default: 0,  null: false
    t.integer "promote",   limit: 4,          default: 0,  null: false
    t.integer "sticky",    limit: 4,          default: 0,  null: false
  end

  add_index "node_revision", ["nid"], name: "nid", using: :btree
  add_index "node_revision", ["uid"], name: "uid", using: :btree

  create_table "node_type", primary_key: "type", force: :cascade do |t|
    t.string  "name",        limit: 255,      default: "", null: false
    t.string  "base",        limit: 255,                   null: false
    t.string  "module",      limit: 255,                   null: false
    t.text    "description", limit: 16777215,              null: false
    t.text    "help",        limit: 16777215,              null: false
    t.integer "has_title",   limit: 1,                     null: false
    t.string  "title_label", limit: 255,      default: "", null: false
    t.integer "custom",      limit: 1,        default: 0,  null: false
    t.integer "modified",    limit: 1,        default: 0,  null: false
    t.integer "locked",      limit: 1,        default: 0,  null: false
    t.integer "disabled",    limit: 1,        default: 0,  null: false
    t.string  "orig_type",   limit: 255,      default: "", null: false
  end

  create_table "queue", primary_key: "item_id", force: :cascade do |t|
    t.string  "name",    limit: 255,        default: "", null: false
    t.binary  "data",    limit: 4294967295
    t.integer "expire",  limit: 4,          default: 0,  null: false
    t.integer "created", limit: 4,          default: 0,  null: false
  end

  add_index "queue", ["expire"], name: "expire", using: :btree
  add_index "queue", ["name", "created"], name: "name_created", using: :btree

  create_table "rdf_mapping", id: false, force: :cascade do |t|
    t.string "type",    limit: 128,        null: false
    t.string "bundle",  limit: 128,        null: false
    t.binary "mapping", limit: 4294967295
  end

  create_table "registry", id: false, force: :cascade do |t|
    t.string  "name",     limit: 255, default: "", null: false
    t.string  "type",     limit: 9,   default: "", null: false
    t.string  "filename", limit: 255,              null: false
    t.string  "module",   limit: 255, default: "", null: false
    t.integer "weight",   limit: 4,   default: 0,  null: false
  end

  add_index "registry", ["type", "weight", "module"], name: "hook", using: :btree

  create_table "registry_file", primary_key: "filename", force: :cascade do |t|
    t.string "hash", limit: 64, null: false
  end

  create_table "role", primary_key: "rid", force: :cascade do |t|
    t.string  "name",   limit: 64, default: "", null: false
    t.integer "weight", limit: 4,  default: 0,  null: false
  end

  add_index "role", ["name", "weight"], name: "name_weight", using: :btree
  add_index "role", ["name"], name: "name", unique: true, using: :btree

  create_table "role_permission", id: false, force: :cascade do |t|
    t.integer "rid",        limit: 4,                null: false
    t.string  "permission", limit: 128, default: "", null: false
    t.string  "module",     limit: 255, default: "", null: false
  end

  add_index "role_permission", ["permission"], name: "permission", using: :btree

  create_table "rules_config", force: :cascade do |t|
    t.string  "name",           limit: 64,                               null: false
    t.string  "label",          limit: 255,        default: "unlabeled", null: false
    t.string  "plugin",         limit: 127,                              null: false
    t.integer "active",         limit: 4,          default: 1,           null: false
    t.integer "weight",         limit: 1,          default: 0,           null: false
    t.integer "status",         limit: 1,          default: 1,           null: false
    t.integer "dirty",          limit: 1,          default: 0,           null: false
    t.string  "module",         limit: 255
    t.integer "access_exposed", limit: 1,          default: 0,           null: false
    t.binary  "data",           limit: 4294967295
  end

  add_index "rules_config", ["name"], name: "name", unique: true, using: :btree
  add_index "rules_config", ["plugin"], name: "plugin", using: :btree

  create_table "rules_dependencies", id: false, force: :cascade do |t|
    t.integer "id",     limit: 4,   null: false
    t.string  "module", limit: 255, null: false
  end

  add_index "rules_dependencies", ["module"], name: "module", using: :btree

  create_table "rules_scheduler", primary_key: "tid", force: :cascade do |t|
    t.string  "config",     limit: 64,    default: "", null: false
    t.integer "date",       limit: 4,                  null: false
    t.text    "state",      limit: 65535
    t.string  "identifier", limit: 255,   default: ""
  end

  add_index "rules_scheduler", ["date"], name: "date", using: :btree

  create_table "rules_tags", id: false, force: :cascade do |t|
    t.integer "id",  limit: 4,   null: false
    t.string  "tag", limit: 255, null: false
  end

  create_table "rules_trigger", id: false, force: :cascade do |t|
    t.integer "id",    limit: 4,                null: false
    t.string  "event", limit: 127, default: "", null: false
  end

  create_table "search_dataset", id: false, force: :cascade do |t|
    t.integer "sid",     limit: 4,          default: 0, null: false
    t.string  "type",    limit: 16,                     null: false
    t.text    "data",    limit: 4294967295,             null: false
    t.integer "reindex", limit: 4,          default: 0, null: false
  end

  create_table "search_index", id: false, force: :cascade do |t|
    t.string  "word",  limit: 50, default: "", null: false
    t.integer "sid",   limit: 4,  default: 0,  null: false
    t.string  "type",  limit: 16,              null: false
    t.float   "score", limit: 24
  end

  add_index "search_index", ["sid", "type"], name: "sid_type", using: :btree

  create_table "search_node_links", id: false, force: :cascade do |t|
    t.integer "sid",     limit: 4,          default: 0,  null: false
    t.string  "type",    limit: 16,         default: "", null: false
    t.integer "nid",     limit: 4,          default: 0,  null: false
    t.text    "caption", limit: 4294967295
  end

  add_index "search_node_links", ["nid"], name: "nid", using: :btree

  create_table "search_total", primary_key: "word", force: :cascade do |t|
    t.float "count", limit: 24
  end

  create_table "semaphore", primary_key: "name", force: :cascade do |t|
    t.string "value",  limit: 255, default: "", null: false
    t.float  "expire", limit: 53,               null: false
  end

  add_index "semaphore", ["expire"], name: "expire", using: :btree
  add_index "semaphore", ["value"], name: "value", using: :btree

  create_table "sequences", primary_key: "value", force: :cascade do |t|
  end

  create_table "services_user", id: false, force: :cascade do |t|
    t.integer "uid",     limit: 4,             null: false
    t.integer "created", limit: 4, default: 0, null: false
    t.integer "changed", limit: 4, default: 0, null: false
  end

  create_table "sessions", id: false, force: :cascade do |t|
    t.integer "uid",       limit: 4,                       null: false
    t.string  "sid",       limit: 128,                     null: false
    t.string  "ssid",      limit: 128,        default: "", null: false
    t.string  "hostname",  limit: 128,        default: "", null: false
    t.integer "timestamp", limit: 4,          default: 0,  null: false
    t.integer "cache",     limit: 4,          default: 0,  null: false
    t.binary  "session",   limit: 4294967295
  end

  add_index "sessions", ["ssid"], name: "ssid", using: :btree
  add_index "sessions", ["timestamp"], name: "timestamp", using: :btree
  add_index "sessions", ["uid"], name: "uid", using: :btree

  create_table "shortcut_set", primary_key: "set_name", force: :cascade do |t|
    t.string "title", limit: 255, default: "", null: false
  end

  create_table "shortcut_set_users", primary_key: "uid", force: :cascade do |t|
    t.string "set_name", limit: 32, default: "", null: false
  end

  add_index "shortcut_set_users", ["set_name"], name: "set_name", using: :btree

  create_table "stylizer", primary_key: "sid", force: :cascade do |t|
    t.string "name",              limit: 255
    t.string "admin_title",       limit: 255
    t.text   "admin_description", limit: 4294967295
    t.text   "settings",          limit: 4294967295
  end

  add_index "stylizer", ["name"], name: "name", unique: true, using: :btree

  create_table "system", primary_key: "filename", force: :cascade do |t|
    t.string  "name",           limit: 255,   default: "", null: false
    t.string  "type",           limit: 12,    default: "", null: false
    t.string  "owner",          limit: 255,   default: "", null: false
    t.integer "status",         limit: 4,     default: 0,  null: false
    t.integer "bootstrap",      limit: 4,     default: 0,  null: false
    t.integer "schema_version", limit: 2,     default: -1, null: false
    t.integer "weight",         limit: 4,     default: 0,  null: false
    t.binary  "info",           limit: 65535
  end

  add_index "system", ["status", "bootstrap", "type", "weight", "name"], name: "system_list", using: :btree
  add_index "system", ["type", "name"], name: "type_name", using: :btree

  create_table "taxonomy_index", id: false, force: :cascade do |t|
    t.integer "nid",     limit: 4, default: 0, null: false
    t.integer "tid",     limit: 4, default: 0, null: false
    t.integer "sticky",  limit: 1, default: 0
    t.integer "created", limit: 4, default: 0, null: false
  end

  add_index "taxonomy_index", ["nid"], name: "nid", using: :btree
  add_index "taxonomy_index", ["tid", "sticky", "created"], name: "term_node", using: :btree

  create_table "taxonomy_term_data", primary_key: "tid", force: :cascade do |t|
    t.integer "vid",         limit: 4,          default: 0,  null: false
    t.string  "name",        limit: 255,        default: "", null: false
    t.text    "description", limit: 4294967295
    t.string  "format",      limit: 255
    t.integer "weight",      limit: 4,          default: 0,  null: false
  end

  add_index "taxonomy_term_data", ["name"], name: "name", using: :btree
  add_index "taxonomy_term_data", ["vid", "name"], name: "vid_name", using: :btree
  add_index "taxonomy_term_data", ["vid", "weight", "name"], name: "taxonomy_tree", using: :btree

  create_table "taxonomy_term_hierarchy", id: false, force: :cascade do |t|
    t.integer "tid",    limit: 4, default: 0, null: false
    t.integer "parent", limit: 4, default: 0, null: false
  end

  add_index "taxonomy_term_hierarchy", ["parent"], name: "parent", using: :btree

  create_table "taxonomy_vocabulary", primary_key: "vid", force: :cascade do |t|
    t.string  "name",         limit: 255,        default: "", null: false
    t.string  "machine_name", limit: 255,        default: "", null: false
    t.text    "description",  limit: 4294967295
    t.integer "hierarchy",    limit: 1,          default: 0,  null: false
    t.string  "module",       limit: 255,        default: "", null: false
    t.integer "weight",       limit: 4,          default: 0,  null: false
  end

  add_index "taxonomy_vocabulary", ["machine_name"], name: "machine_name", unique: true, using: :btree
  add_index "taxonomy_vocabulary", ["weight", "name"], name: "list", using: :btree

  create_table "url_alias", primary_key: "pid", force: :cascade do |t|
    t.string "source",   limit: 255, default: "", null: false
    t.string "alias",    limit: 255, default: "", null: false
    t.string "language", limit: 12,  default: "", null: false
  end

  add_index "url_alias", ["alias", "language", "pid"], name: "alias_language_pid", using: :btree
  add_index "url_alias", ["source", "language", "pid"], name: "source_language_pid", using: :btree

  create_table "users", primary_key: "uid", force: :cascade do |t|
    t.string  "name",             limit: 60,         default: "", null: false
    t.string  "pass",             limit: 128,        default: "", null: false
    t.string  "mail",             limit: 254,        default: ""
    t.string  "theme",            limit: 255,        default: "", null: false
    t.string  "signature",        limit: 255,        default: "", null: false
    t.string  "signature_format", limit: 255
    t.integer "created",          limit: 4,          default: 0,  null: false
    t.integer "access",           limit: 4,          default: 0,  null: false
    t.integer "login",            limit: 4,          default: 0,  null: false
    t.integer "status",           limit: 1,          default: 0,  null: false
    t.string  "timezone",         limit: 32
    t.string  "language",         limit: 12,         default: "", null: false
    t.integer "picture",          limit: 4,          default: 0,  null: false
    t.string  "init",             limit: 254,        default: ""
    t.binary  "data",             limit: 4294967295
  end

  add_index "users", ["access"], name: "access", using: :btree
  add_index "users", ["created"], name: "created", using: :btree
  add_index "users", ["mail"], name: "mail", using: :btree
  add_index "users", ["name"], name: "name", unique: true, using: :btree
  add_index "users", ["picture"], name: "picture", using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "uid", limit: 4, default: 0, null: false
    t.integer "rid", limit: 4, default: 0, null: false
  end

  add_index "users_roles", ["rid"], name: "rid", using: :btree

  create_table "variable", primary_key: "name", force: :cascade do |t|
    t.binary "value", limit: 4294967295, null: false
  end

  create_table "views_calc_fields", primary_key: "cid", force: :cascade do |t|
    t.string "label",     limit: 255,   default: "", null: false
    t.string "format",    limit: 255,   default: "", null: false
    t.string "custom",    limit: 255,   default: "", null: false
    t.string "base",      limit: 255,   default: "", null: false
    t.text   "tablelist", limit: 65535,              null: false
    t.text   "fieldlist", limit: 65535,              null: false
    t.text   "calc",      limit: 65535,              null: false
  end

  add_index "views_calc_fields", ["cid"], name: "cid", using: :btree

  create_table "views_display", id: false, force: :cascade do |t|
    t.integer "vid",             limit: 4,          default: 0,  null: false
    t.string  "id",              limit: 64,         default: "", null: false
    t.string  "display_title",   limit: 64,         default: "", null: false
    t.string  "display_plugin",  limit: 64,         default: "", null: false
    t.integer "position",        limit: 4,          default: 0
    t.text    "display_options", limit: 4294967295
  end

  add_index "views_display", ["vid", "position"], name: "vid", using: :btree

  create_table "views_view", primary_key: "vid", force: :cascade do |t|
    t.string  "name",        limit: 128, default: "", null: false
    t.string  "description", limit: 255, default: ""
    t.string  "tag",         limit: 255, default: ""
    t.string  "base_table",  limit: 64,  default: "", null: false
    t.string  "human_name",  limit: 255, default: ""
    t.integer "core",        limit: 4,   default: 0
  end

  add_index "views_view", ["name"], name: "name", unique: true, using: :btree

  create_table "watchdog", primary_key: "wid", force: :cascade do |t|
    t.integer "uid",       limit: 4,          default: 0,  null: false
    t.string  "type",      limit: 64,         default: "", null: false
    t.text    "message",   limit: 4294967295,              null: false
    t.binary  "variables", limit: 4294967295,              null: false
    t.integer "severity",  limit: 1,          default: 0,  null: false
    t.string  "link",      limit: 255,        default: ""
    t.text    "location",  limit: 65535,                   null: false
    t.text    "referer",   limit: 65535
    t.string  "hostname",  limit: 128,        default: "", null: false
    t.integer "timestamp", limit: 4,          default: 0,  null: false
  end

  add_index "watchdog", ["severity"], name: "severity", using: :btree
  add_index "watchdog", ["type"], name: "type", using: :btree
  add_index "watchdog", ["uid"], name: "uid", using: :btree

  create_table "webform", primary_key: "nid", force: :cascade do |t|
    t.text    "confirmation",                     limit: 65535,                            null: false
    t.string  "confirmation_format",              limit: 255
    t.string  "redirect_url",                     limit: 2048,  default: "<confirmation>"
    t.integer "status",                           limit: 1,     default: 1,                null: false
    t.integer "block",                            limit: 1,     default: 0,                null: false
    t.integer "allow_draft",                      limit: 1,     default: 0,                null: false
    t.integer "auto_save",                        limit: 1,     default: 0,                null: false
    t.integer "submit_notice",                    limit: 1,     default: 1,                null: false
    t.string  "submit_text",                      limit: 255
    t.integer "submit_limit",                     limit: 1,     default: -1,               null: false
    t.integer "submit_interval",                  limit: 4,     default: -1,               null: false
    t.integer "total_submit_limit",               limit: 4,     default: -1,               null: false
    t.integer "total_submit_interval",            limit: 4,     default: -1,               null: false
    t.integer "progressbar_bar",                  limit: 1,     default: 0,                null: false
    t.integer "progressbar_page_number",          limit: 1,     default: 0,                null: false
    t.integer "progressbar_percent",              limit: 1,     default: 0,                null: false
    t.integer "progressbar_pagebreak_labels",     limit: 1,     default: 0,                null: false
    t.integer "progressbar_include_confirmation", limit: 1,     default: 0,                null: false
    t.string  "progressbar_label_first",          limit: 255
    t.string  "progressbar_label_confirmation",   limit: 255
    t.integer "preview",                          limit: 1,     default: 0,                null: false
    t.string  "preview_next_button_label",        limit: 255
    t.string  "preview_prev_button_label",        limit: 255
    t.string  "preview_title",                    limit: 255
    t.text    "preview_message",                  limit: 65535,                            null: false
    t.string  "preview_message_format",           limit: 255
    t.text    "preview_excluded_components",      limit: 65535,                            null: false
    t.integer "next_serial",                      limit: 4,     default: 1,                null: false
    t.integer "confidential",                     limit: 1,     default: 0,                null: false
  end

  create_table "webform_civicrm_forms", primary_key: "nid", force: :cascade do |t|
    t.text    "data",                 limit: 65535
    t.text    "prefix_known",         limit: 65535,              null: false
    t.text    "prefix_unknown",       limit: 65535,              null: false
    t.string  "message",              limit: 255,   default: "", null: false
    t.integer "confirm_subscription", limit: 1,     default: 0,  null: false
    t.integer "block_unknown_users",  limit: 1,     default: 0,  null: false
    t.integer "create_fieldsets",     limit: 1,     default: 0,  null: false
    t.string  "new_contact_source",   limit: 255,   default: "", null: false
  end

  create_table "webform_civicrm_submissions", primary_key: "sid", force: :cascade do |t|
    t.string  "contact_id",      limit: 2000, default: "", null: false
    t.integer "activity_id",     limit: 4,    default: 0,  null: false
    t.integer "contribution_id", limit: 4,    default: 0,  null: false
  end

  create_table "webform_component", id: false, force: :cascade do |t|
    t.integer "nid",      limit: 4,     default: 0, null: false
    t.integer "cid",      limit: 2,     default: 0, null: false
    t.integer "pid",      limit: 2,     default: 0, null: false
    t.string  "form_key", limit: 128
    t.text    "name",     limit: 65535,             null: false
    t.string  "type",     limit: 16
    t.text    "value",    limit: 65535,             null: false
    t.text    "extra",    limit: 65535,             null: false
    t.integer "required", limit: 1,     default: 0, null: false
    t.integer "weight",   limit: 2,     default: 0, null: false
  end

  create_table "webform_conditional", id: false, force: :cascade do |t|
    t.integer "nid",    limit: 4,   default: 0, null: false
    t.integer "rgid",   limit: 2,   default: 0, null: false
    t.string  "andor",  limit: 128
    t.integer "weight", limit: 2,   default: 0, null: false
  end

  create_table "webform_conditional_actions", id: false, force: :cascade do |t|
    t.integer "nid",         limit: 4,     default: 0, null: false
    t.integer "rgid",        limit: 2,     default: 0, null: false
    t.integer "aid",         limit: 2,     default: 0, null: false
    t.string  "target_type", limit: 128
    t.string  "target",      limit: 128
    t.integer "invert",      limit: 2,     default: 0, null: false
    t.string  "action",      limit: 128
    t.text    "argument",    limit: 65535
  end

  create_table "webform_conditional_rules", id: false, force: :cascade do |t|
    t.integer "nid",         limit: 4,     default: 0, null: false
    t.integer "rgid",        limit: 2,     default: 0, null: false
    t.integer "rid",         limit: 2,     default: 0, null: false
    t.string  "source_type", limit: 128
    t.integer "source",      limit: 2,     default: 0, null: false
    t.string  "operator",    limit: 128
    t.text    "value",       limit: 65535
  end

  create_table "webform_emails", id: false, force: :cascade do |t|
    t.integer "nid",                 limit: 4,     default: 0, null: false
    t.integer "eid",                 limit: 2,     default: 0, null: false
    t.text    "email",               limit: 65535
    t.text    "subject",             limit: 65535
    t.text    "from_name",           limit: 65535
    t.text    "from_address",        limit: 65535
    t.text    "template",            limit: 65535
    t.text    "excluded_components", limit: 65535,             null: false
    t.integer "html",                limit: 1,     default: 0, null: false
    t.integer "attachments",         limit: 1,     default: 0, null: false
    t.text    "extra",               limit: 65535,             null: false
    t.integer "exclude_empty",       limit: 1,     default: 0, null: false
    t.integer "status",              limit: 1,     default: 1, null: false
  end

  create_table "webform_last_download", id: false, force: :cascade do |t|
    t.integer "nid",       limit: 4, default: 0, null: false
    t.integer "uid",       limit: 4, default: 0, null: false
    t.integer "sid",       limit: 4, default: 0, null: false
    t.integer "requested", limit: 4, default: 0, null: false
  end

  create_table "webform_roles", id: false, force: :cascade do |t|
    t.integer "nid", limit: 4, default: 0, null: false
    t.integer "rid", limit: 4, default: 0, null: false
  end

  create_table "webform_submissions", primary_key: "sid", force: :cascade do |t|
    t.integer "nid",                limit: 4,   default: 0, null: false
    t.integer "uid",                limit: 4,   default: 0, null: false
    t.integer "is_draft",           limit: 1,   default: 0, null: false
    t.integer "submitted",          limit: 4,   default: 0, null: false
    t.string  "remote_addr",        limit: 128
    t.integer "serial",             limit: 4,               null: false
    t.integer "completed",          limit: 4,   default: 0, null: false
    t.integer "modified",           limit: 4,   default: 0, null: false
    t.integer "highest_valid_page", limit: 2,   default: 0, null: false
  end

  add_index "webform_submissions", ["nid", "serial"], name: "nid_serial", unique: true, using: :btree
  add_index "webform_submissions", ["nid", "sid"], name: "nid_sid", using: :btree
  add_index "webform_submissions", ["nid", "uid", "sid"], name: "nid_uid_sid", using: :btree
  add_index "webform_submissions", ["sid", "nid"], name: "sid_nid", unique: true, using: :btree

  create_table "webform_submitted_data", id: false, force: :cascade do |t|
    t.integer "nid",  limit: 4,        default: 0,   null: false
    t.integer "sid",  limit: 4,        default: 0,   null: false
    t.integer "cid",  limit: 2,        default: 0,   null: false
    t.string  "no",   limit: 128,      default: "0", null: false
    t.text    "data", limit: 16777215,               null: false
  end

  add_index "webform_submitted_data", ["data"], name: "data", length: {"data"=>64}, using: :btree
  add_index "webform_submitted_data", ["nid"], name: "nid", using: :btree
  add_index "webform_submitted_data", ["sid", "nid"], name: "sid_nid", using: :btree

  create_table "wysiwyg", primary_key: "format", force: :cascade do |t|
    t.string "editor",   limit: 128,   default: "", null: false
    t.text   "settings", limit: 65535
  end

  create_table "wysiwyg_user", id: false, force: :cascade do |t|
    t.integer "uid",    limit: 4,   default: 0, null: false
    t.string  "format", limit: 255,             null: false
    t.integer "status", limit: 1,   default: 0, null: false
  end

  add_index "wysiwyg_user", ["uid"], name: "uid", using: :btree

  add_foreign_key "civicrm_acl_cache", "civicrm_acl", column: "acl_id", name: "FK_civicrm_acl_cache_acl_id", on_delete: :cascade
  add_foreign_key "civicrm_acl_cache", "civicrm_contact", column: "contact_id", name: "FK_civicrm_acl_cache_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_acl_contact_cache", "civicrm_contact", column: "contact_id", name: "FK_civicrm_acl_contact_cache_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_acl_contact_cache", "civicrm_contact", column: "user_id", name: "FK_civicrm_acl_contact_cache_user_id", on_delete: :cascade
  add_foreign_key "civicrm_action_log", "civicrm_action_schedule", column: "action_schedule_id", name: "FK_civicrm_action_log_action_schedule_id", on_delete: :cascade
  add_foreign_key "civicrm_action_log", "civicrm_contact", column: "contact_id", name: "FK_civicrm_action_log_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_action_schedule", "civicrm_group", column: "group_id", name: "FK_civicrm_action_schedule_group_id", on_delete: :nullify
  add_foreign_key "civicrm_action_schedule", "civicrm_msg_template", column: "msg_template_id", name: "FK_civicrm_action_schedule_msg_template_id", on_delete: :nullify
  add_foreign_key "civicrm_action_schedule", "civicrm_msg_template", column: "sms_template_id", name: "FK_civicrm_action_schedule_sms_template_id", on_delete: :nullify
  add_foreign_key "civicrm_action_schedule", "civicrm_sms_provider", column: "sms_provider_id", name: "FK_civicrm_action_schedule_sms_provider_id", on_delete: :nullify
  add_foreign_key "civicrm_activity", "civicrm_activity", column: "original_id", name: "FK_civicrm_activity_original_id", on_delete: :cascade
  add_foreign_key "civicrm_activity", "civicrm_activity", column: "parent_id", name: "FK_civicrm_activity_parent_id", on_delete: :cascade
  add_foreign_key "civicrm_activity", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_activity_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_activity", "civicrm_phone", column: "phone_id", name: "FK_civicrm_activity_phone_id", on_delete: :nullify
  add_foreign_key "civicrm_activity", "civicrm_relationship", column: "relationship_id", name: "FK_civicrm_activity_relationship_id", on_delete: :nullify
  add_foreign_key "civicrm_activity_contact", "civicrm_activity", column: "activity_id", name: "FK_civicrm_activity_contact_activity_id", on_delete: :cascade
  add_foreign_key "civicrm_activity_contact", "civicrm_contact", column: "contact_id", name: "FK_civicrm_activity_contact_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_address", "civicrm_address", column: "master_id", name: "FK_civicrm_address_master_id", on_delete: :nullify
  add_foreign_key "civicrm_address", "civicrm_contact", column: "contact_id", name: "FK_civicrm_address_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_address", "civicrm_country", column: "country_id", name: "FK_civicrm_address_country_id", on_delete: :nullify
  add_foreign_key "civicrm_address", "civicrm_county", column: "county_id", name: "FK_civicrm_address_county_id", on_delete: :nullify
  add_foreign_key "civicrm_address", "civicrm_state_province", column: "state_province_id", name: "FK_civicrm_address_state_province_id", on_delete: :nullify
  add_foreign_key "civicrm_batch", "civicrm_contact", column: "created_id", name: "FK_civicrm_batch_created_id", on_delete: :nullify
  add_foreign_key "civicrm_batch", "civicrm_contact", column: "modified_id", name: "FK_civicrm_batch_modified_id", on_delete: :nullify
  add_foreign_key "civicrm_batch", "civicrm_saved_search", column: "saved_search_id", name: "FK_civicrm_batch_saved_search_id", on_delete: :nullify
  add_foreign_key "civicrm_cache", "civicrm_component", column: "component_id", name: "FK_civicrm_cache_component_id"
  add_foreign_key "civicrm_campaign", "civicrm_campaign", column: "parent_id", name: "FK_civicrm_campaign_parent_id", on_delete: :nullify
  add_foreign_key "civicrm_campaign", "civicrm_contact", column: "created_id", name: "FK_civicrm_campaign_created_id", on_delete: :nullify
  add_foreign_key "civicrm_campaign", "civicrm_contact", column: "last_modified_id", name: "FK_civicrm_campaign_last_modified_id", on_delete: :nullify
  add_foreign_key "civicrm_campaign_group", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_campaign_group_campaign_id", on_delete: :cascade
  add_foreign_key "civicrm_case", "civicrm_case_type", column: "case_type_id", name: "FK_civicrm_case_case_type_id"
  add_foreign_key "civicrm_case_activity", "civicrm_activity", column: "activity_id", name: "FK_civicrm_case_activity_activity_id", on_delete: :cascade
  add_foreign_key "civicrm_case_activity", "civicrm_case", column: "case_id", name: "FK_civicrm_case_activity_case_id", on_delete: :cascade
  add_foreign_key "civicrm_case_contact", "civicrm_case", column: "case_id", name: "FK_civicrm_case_contact_case_id", on_delete: :cascade
  add_foreign_key "civicrm_case_contact", "civicrm_contact", column: "contact_id", name: "FK_civicrm_case_contact_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_contact", "civicrm_contact", column: "employer_id", name: "FK_civicrm_contact_employer_id", on_delete: :nullify
  add_foreign_key "civicrm_contact", "civicrm_contact", column: "primary_contact_id", name: "FK_civicrm_contact_primary_contact_id", on_delete: :nullify
  add_foreign_key "civicrm_contact_type", "civicrm_contact_type", column: "parent_id", name: "FK_civicrm_contact_type_parent_id"
  add_foreign_key "civicrm_contribution", "civicrm_address", column: "address_id", name: "FK_civicrm_contribution_address_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_contribution_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution", "civicrm_contact", column: "contact_id", name: "FK_civicrm_contribution_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_contribution", "civicrm_contribution_page", column: "contribution_page_id", name: "FK_civicrm_contribution_contribution_page_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution", "civicrm_contribution_recur", column: "contribution_recur_id", name: "FK_civicrm_contribution_contribution_recur_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_contribution_financial_type_id"
  add_foreign_key "civicrm_contribution_page", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_contribution_page_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_page", "civicrm_contact", column: "created_id", name: "FK_civicrm_contribution_page_created_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_page", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_contribution_page_financial_type_id"
  add_foreign_key "civicrm_contribution_product", "civicrm_contribution", column: "contribution_id", name: "FK_civicrm_contribution_product_contribution_id", on_delete: :cascade
  add_foreign_key "civicrm_contribution_product", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_contribution_product_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_recur", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_contribution_recur_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_recur", "civicrm_contact", column: "contact_id", name: "FK_civicrm_contribution_recur_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_contribution_recur", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_contribution_recur_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_recur", "civicrm_payment_processor", column: "payment_processor_id", name: "FK_civicrm_contribution_recur_payment_processor_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_recur", "civicrm_payment_token", column: "payment_token_id", name: "FK_civicrm_contribution_recur_payment_token_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_soft", "civicrm_contact", column: "contact_id", name: "FK_civicrm_contribution_soft_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_contribution_soft", "civicrm_contribution", column: "contribution_id", name: "FK_civicrm_contribution_soft_contribution_id", on_delete: :cascade
  add_foreign_key "civicrm_contribution_soft", "civicrm_pcp", column: "pcp_id", name: "FK_civicrm_contribution_soft_pcp_id", on_delete: :nullify
  add_foreign_key "civicrm_contribution_widget", "civicrm_contribution_page", column: "contribution_page_id", name: "FK_civicrm_contribution_widget_contribution_page_id", on_delete: :cascade
  add_foreign_key "civicrm_country", "civicrm_address_format", column: "address_format_id", name: "FK_civicrm_country_address_format_id"
  add_foreign_key "civicrm_country", "civicrm_worldregion", column: "region_id", name: "FK_civicrm_country_region_id"
  add_foreign_key "civicrm_county", "civicrm_state_province", column: "state_province_id", name: "FK_civicrm_county_state_province_id"
  add_foreign_key "civicrm_custom_field", "civicrm_custom_group", column: "custom_group_id", name: "FK_civicrm_custom_field_custom_group_id", on_delete: :cascade
  add_foreign_key "civicrm_custom_group", "civicrm_contact", column: "created_id", name: "FK_civicrm_custom_group_created_id", on_delete: :nullify
  add_foreign_key "civicrm_dashboard", "civicrm_domain", column: "domain_id", name: "FK_civicrm_dashboard_domain_id"
  add_foreign_key "civicrm_dashboard_contact", "civicrm_contact", column: "contact_id", name: "FK_civicrm_dashboard_contact_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_dashboard_contact", "civicrm_dashboard", column: "dashboard_id", name: "FK_civicrm_dashboard_contact_dashboard_id", on_delete: :cascade
  add_foreign_key "civicrm_dedupe_exception", "civicrm_contact", column: "contact_id1", name: "FK_civicrm_dedupe_exception_contact_id1", on_delete: :cascade
  add_foreign_key "civicrm_dedupe_exception", "civicrm_contact", column: "contact_id2", name: "FK_civicrm_dedupe_exception_contact_id2", on_delete: :cascade
  add_foreign_key "civicrm_dedupe_rule", "civicrm_dedupe_rule_group", column: "dedupe_rule_group_id", name: "FK_civicrm_dedupe_rule_dedupe_rule_group_id"
  add_foreign_key "civicrm_discount", "civicrm_price_set", column: "price_set_id", name: "FK_civicrm_discount_price_set_id", on_delete: :cascade
  add_foreign_key "civicrm_domain", "civicrm_contact", column: "contact_id", name: "FK_civicrm_domain_contact_id"
  add_foreign_key "civicrm_email", "civicrm_contact", column: "contact_id", name: "FK_civicrm_email_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_entity_batch", "civicrm_batch", column: "batch_id", name: "FK_civicrm_entity_batch_batch_id", on_delete: :cascade
  add_foreign_key "civicrm_entity_file", "civicrm_file", column: "file_id", name: "FK_civicrm_entity_file_file_id"
  add_foreign_key "civicrm_entity_financial_account", "civicrm_financial_account", column: "financial_account_id", name: "FK_civicrm_entity_financial_account_financial_account_id"
  add_foreign_key "civicrm_entity_financial_trxn", "civicrm_financial_trxn", column: "financial_trxn_id", name: "FK_civicrm_entity_financial_trxn_financial_trxn_id", on_delete: :nullify
  add_foreign_key "civicrm_entity_tag", "civicrm_tag", column: "tag_id", name: "FK_civicrm_entity_tag_tag_id", on_delete: :cascade
  add_foreign_key "civicrm_event", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_event_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_event", "civicrm_contact", column: "created_id", name: "FK_civicrm_event_created_id", on_delete: :nullify
  add_foreign_key "civicrm_event", "civicrm_dedupe_rule_group", column: "dedupe_rule_group_id", name: "FK_civicrm_event_dedupe_rule_group_id"
  add_foreign_key "civicrm_event", "civicrm_loc_block", column: "loc_block_id", name: "FK_civicrm_event_loc_block_id", on_delete: :nullify
  add_foreign_key "civicrm_event_carts", "civicrm_contact", column: "user_id", name: "FK_civicrm_event_carts_user_id", on_delete: :nullify
  add_foreign_key "civicrm_events_in_carts", "civicrm_event", column: "event_id", name: "FK_civicrm_events_in_carts_event_id", on_delete: :cascade
  add_foreign_key "civicrm_events_in_carts", "civicrm_event_carts", column: "event_cart_id", name: "FK_civicrm_events_in_carts_event_cart_id", on_delete: :cascade
  add_foreign_key "civicrm_financial_account", "civicrm_contact", column: "contact_id", name: "FK_civicrm_financial_account_contact_id", on_delete: :nullify
  add_foreign_key "civicrm_financial_account", "civicrm_financial_account", column: "parent_id", name: "FK_civicrm_financial_account_parent_id"
  add_foreign_key "civicrm_financial_item", "civicrm_contact", column: "contact_id", name: "FK_civicrm_financial_item_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_financial_item", "civicrm_financial_account", column: "financial_account_id", name: "FK_civicrm_financial_item_financial_account_id"
  add_foreign_key "civicrm_financial_trxn", "civicrm_financial_account", column: "from_financial_account_id", name: "FK_civicrm_financial_trxn_from_financial_account_id"
  add_foreign_key "civicrm_financial_trxn", "civicrm_financial_account", column: "to_financial_account_id", name: "FK_civicrm_financial_trxn_to_financial_account_id"
  add_foreign_key "civicrm_financial_trxn", "civicrm_payment_processor", column: "payment_processor_id", name: "FK_civicrm_financial_trxn_payment_processor_id", on_delete: :nullify
  add_foreign_key "civicrm_grant", "civicrm_contact", column: "contact_id", name: "FK_civicrm_grant_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_grant", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_grant_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_group", "civicrm_contact", column: "created_id", name: "FK_civicrm_group_created_id", on_delete: :nullify
  add_foreign_key "civicrm_group", "civicrm_contact", column: "modified_id", name: "FK_civicrm_group_modified_id", on_delete: :nullify
  add_foreign_key "civicrm_group", "civicrm_saved_search", column: "saved_search_id", name: "FK_civicrm_group_saved_search_id", on_delete: :nullify
  add_foreign_key "civicrm_group_contact", "civicrm_contact", column: "contact_id", name: "FK_civicrm_group_contact_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_group_contact", "civicrm_email", column: "email_id", name: "FK_civicrm_group_contact_email_id"
  add_foreign_key "civicrm_group_contact", "civicrm_group", column: "group_id", name: "FK_civicrm_group_contact_group_id", on_delete: :cascade
  add_foreign_key "civicrm_group_contact", "civicrm_loc_block", column: "location_id", name: "FK_civicrm_group_contact_location_id", on_delete: :nullify
  add_foreign_key "civicrm_group_contact_cache", "civicrm_contact", column: "contact_id", name: "FK_civicrm_group_contact_cache_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_group_contact_cache", "civicrm_group", column: "group_id", name: "FK_civicrm_group_contact_cache_group_id", on_delete: :cascade
  add_foreign_key "civicrm_group_nesting", "civicrm_group", column: "child_group_id", name: "FK_civicrm_group_nesting_child_group_id", on_delete: :cascade
  add_foreign_key "civicrm_group_nesting", "civicrm_group", column: "parent_group_id", name: "FK_civicrm_group_nesting_parent_group_id", on_delete: :cascade
  add_foreign_key "civicrm_group_organization", "civicrm_contact", column: "organization_id", name: "FK_civicrm_group_organization_organization_id", on_delete: :cascade
  add_foreign_key "civicrm_group_organization", "civicrm_group", column: "group_id", name: "FK_civicrm_group_organization_group_id", on_delete: :cascade
  add_foreign_key "civicrm_im", "civicrm_contact", column: "contact_id", name: "FK_civicrm_im_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_job", "civicrm_domain", column: "domain_id", name: "FK_civicrm_job_domain_id"
  add_foreign_key "civicrm_job_log", "civicrm_domain", column: "domain_id", name: "FK_civicrm_job_log_domain_id"
  add_foreign_key "civicrm_line_item", "civicrm_contribution", column: "contribution_id", name: "FK_civicrm_line_item_contribution_id", on_delete: :nullify
  add_foreign_key "civicrm_line_item", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_line_item_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_line_item", "civicrm_price_field", column: "price_field_id", name: "FK_civicrm_line_item_price_field_id", on_delete: :nullify
  add_foreign_key "civicrm_line_item", "civicrm_price_field_value", column: "price_field_value_id", name: "FK_civicrm_line_item_price_field_value_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_address", column: "address_2_id", name: "FK_civicrm_loc_block_address_2_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_address", column: "address_id", name: "FK_civicrm_loc_block_address_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_email", column: "email_2_id", name: "FK_civicrm_loc_block_email_2_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_email", column: "email_id", name: "FK_civicrm_loc_block_email_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_im", column: "im_2_id", name: "FK_civicrm_loc_block_im_2_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_im", column: "im_id", name: "FK_civicrm_loc_block_im_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_phone", column: "phone_2_id", name: "FK_civicrm_loc_block_phone_2_id", on_delete: :nullify
  add_foreign_key "civicrm_loc_block", "civicrm_phone", column: "phone_id", name: "FK_civicrm_loc_block_phone_id", on_delete: :nullify
  add_foreign_key "civicrm_log", "civicrm_contact", column: "modified_id", name: "FK_civicrm_log_modified_id", on_delete: :cascade
  add_foreign_key "civicrm_mail_settings", "civicrm_domain", column: "domain_id", name: "FK_civicrm_mail_settings_domain_id"
  add_foreign_key "civicrm_mailing", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_mailing_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_contact", column: "approver_id", name: "FK_civicrm_mailing_approver_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_contact", column: "created_id", name: "FK_civicrm_mailing_created_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_contact", column: "scheduled_id", name: "FK_civicrm_mailing_scheduled_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_domain", column: "domain_id", name: "FK_civicrm_mailing_domain_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_location_type", column: "location_type_id", name: "FK_civicrm_mailing_location_type_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_mailing_component", column: "footer_id", name: "FK_civicrm_mailing_footer_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_mailing_component", column: "header_id", name: "FK_civicrm_mailing_header_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_mailing_component", column: "optout_id", name: "FK_civicrm_mailing_optout_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_mailing_component", column: "reply_id", name: "FK_civicrm_mailing_reply_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_mailing_component", column: "unsubscribe_id", name: "FK_civicrm_mailing_unsubscribe_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_msg_template", column: "msg_template_id", name: "FK_civicrm_mailing_msg_template_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing", "civicrm_sms_provider", column: "sms_provider_id", name: "FK_civicrm_mailing_sms_provider_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing_abtest", "civicrm_contact", column: "created_id", name: "FK_civicrm_mailing_abtest_created_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing_bounce_pattern", "civicrm_mailing_bounce_type", column: "bounce_type_id", name: "FK_civicrm_mailing_bounce_pattern_bounce_type_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_bounce", "civicrm_mailing_event_queue", column: "event_queue_id", name: "FK_civicrm_mailing_event_bounce_event_queue_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_confirm", "civicrm_mailing_event_subscribe", column: "event_subscribe_id", name: "FK_civicrm_mailing_event_confirm_event_subscribe_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_delivered", "civicrm_mailing_event_queue", column: "event_queue_id", name: "FK_civicrm_mailing_event_delivered_event_queue_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_forward", "civicrm_mailing_event_queue", column: "dest_queue_id", name: "FK_civicrm_mailing_event_forward_dest_queue_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing_event_forward", "civicrm_mailing_event_queue", column: "event_queue_id", name: "FK_civicrm_mailing_event_forward_event_queue_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_opened", "civicrm_mailing_event_queue", column: "event_queue_id", name: "FK_civicrm_mailing_event_opened_event_queue_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_queue", "civicrm_contact", column: "contact_id", name: "FK_civicrm_mailing_event_queue_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_queue", "civicrm_email", column: "email_id", name: "FK_civicrm_mailing_event_queue_email_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing_event_queue", "civicrm_mailing_job", column: "job_id", name: "FK_civicrm_mailing_event_queue_job_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_queue", "civicrm_phone", column: "phone_id", name: "FK_civicrm_mailing_event_queue_phone_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing_event_reply", "civicrm_mailing_event_queue", column: "event_queue_id", name: "FK_civicrm_mailing_event_reply_event_queue_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_subscribe", "civicrm_contact", column: "contact_id", name: "FK_civicrm_mailing_event_subscribe_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_subscribe", "civicrm_group", column: "group_id", name: "FK_civicrm_mailing_event_subscribe_group_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_trackable_url_open", "civicrm_mailing_event_queue", column: "event_queue_id", name: "FK_civicrm_mailing_event_trackable_url_open_event_queue_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_trackable_url_open", "civicrm_mailing_trackable_url", column: "trackable_url_id", name: "FK_civicrm_mailing_event_trackable_url_open_trackable_url_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_event_unsubscribe", "civicrm_mailing_event_queue", column: "event_queue_id", name: "FK_civicrm_mailing_event_unsubscribe_event_queue_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_group", "civicrm_mailing", column: "mailing_id", name: "FK_civicrm_mailing_group_mailing_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_job", "civicrm_mailing", column: "mailing_id", name: "FK_civicrm_mailing_job_mailing_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_job", "civicrm_mailing_job", column: "parent_id", name: "FK_civicrm_mailing_job_parent_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_recipients", "civicrm_contact", column: "contact_id", name: "FK_civicrm_mailing_recipients_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_recipients", "civicrm_email", column: "email_id", name: "FK_civicrm_mailing_recipients_email_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing_recipients", "civicrm_mailing", column: "mailing_id", name: "FK_civicrm_mailing_recipients_mailing_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_recipients", "civicrm_phone", column: "phone_id", name: "FK_civicrm_mailing_recipients_phone_id", on_delete: :nullify
  add_foreign_key "civicrm_mailing_spool", "civicrm_mailing_job", column: "job_id", name: "FK_civicrm_mailing_spool_job_id", on_delete: :cascade
  add_foreign_key "civicrm_mailing_trackable_url", "civicrm_mailing", column: "mailing_id", name: "FK_civicrm_mailing_trackable_url_mailing_id", on_delete: :cascade
  add_foreign_key "civicrm_mapping_field", "civicrm_location_type", column: "location_type_id", name: "FK_civicrm_mapping_field_location_type_id"
  add_foreign_key "civicrm_mapping_field", "civicrm_mapping", column: "mapping_id", name: "FK_civicrm_mapping_field_mapping_id"
  add_foreign_key "civicrm_mapping_field", "civicrm_relationship_type", column: "relationship_type_id", name: "FK_civicrm_mapping_field_relationship_type_id"
  add_foreign_key "civicrm_membership", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_membership_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_membership", "civicrm_contact", column: "contact_id", name: "FK_civicrm_membership_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_membership", "civicrm_contribution_recur", column: "contribution_recur_id", name: "FK_civicrm_membership_contribution_recur_id", on_delete: :nullify
  add_foreign_key "civicrm_membership", "civicrm_membership", column: "owner_membership_id", name: "FK_civicrm_membership_owner_membership_id", on_delete: :nullify
  add_foreign_key "civicrm_membership", "civicrm_membership_status", column: "status_id", name: "FK_civicrm_membership_status_id", on_delete: :cascade
  add_foreign_key "civicrm_membership", "civicrm_membership_type", column: "membership_type_id", name: "FK_civicrm_membership_membership_type_id", on_delete: :cascade
  add_foreign_key "civicrm_membership_block", "civicrm_contribution_page", column: "entity_id", name: "FK_civicrm_membership_block_entity_id"
  add_foreign_key "civicrm_membership_block", "civicrm_membership_type", column: "membership_type_default", name: "FK_civicrm_membership_block_membership_type_default"
  add_foreign_key "civicrm_membership_log", "civicrm_contact", column: "modified_id", name: "FK_civicrm_membership_log_modified_id", on_delete: :nullify
  add_foreign_key "civicrm_membership_log", "civicrm_membership", column: "membership_id", name: "FK_civicrm_membership_log_membership_id", on_delete: :cascade
  add_foreign_key "civicrm_membership_log", "civicrm_membership_status", column: "status_id", name: "FK_civicrm_membership_log_status_id", on_delete: :cascade
  add_foreign_key "civicrm_membership_log", "civicrm_membership_type", column: "membership_type_id", name: "FK_civicrm_membership_log_membership_type_id", on_delete: :nullify
  add_foreign_key "civicrm_membership_payment", "civicrm_contribution", column: "contribution_id", name: "FK_civicrm_membership_payment_contribution_id", on_delete: :cascade
  add_foreign_key "civicrm_membership_payment", "civicrm_membership", column: "membership_id", name: "FK_civicrm_membership_payment_membership_id", on_delete: :cascade
  add_foreign_key "civicrm_membership_type", "civicrm_contact", column: "member_of_contact_id", name: "FK_civicrm_membership_type_member_of_contact_id"
  add_foreign_key "civicrm_membership_type", "civicrm_domain", column: "domain_id", name: "FK_civicrm_membership_type_domain_id"
  add_foreign_key "civicrm_membership_type", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_membership_type_financial_type_id"
  add_foreign_key "civicrm_menu", "civicrm_component", column: "component_id", name: "FK_civicrm_menu_component_id"
  add_foreign_key "civicrm_menu", "civicrm_domain", column: "domain_id", name: "FK_civicrm_menu_domain_id"
  add_foreign_key "civicrm_navigation", "civicrm_domain", column: "domain_id", name: "FK_civicrm_navigation_domain_id"
  add_foreign_key "civicrm_navigation", "civicrm_navigation", column: "parent_id", name: "FK_civicrm_navigation_parent_id", on_delete: :cascade
  add_foreign_key "civicrm_note", "civicrm_contact", column: "contact_id", name: "FK_civicrm_note_contact_id", on_delete: :nullify
  add_foreign_key "civicrm_openid", "civicrm_contact", column: "contact_id", name: "FK_civicrm_openid_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_option_value", "civicrm_component", column: "component_id", name: "FK_civicrm_option_value_component_id"
  add_foreign_key "civicrm_option_value", "civicrm_domain", column: "domain_id", name: "FK_civicrm_option_value_domain_id"
  add_foreign_key "civicrm_option_value", "civicrm_option_group", column: "option_group_id", name: "FK_civicrm_option_value_option_group_id", on_delete: :cascade
  add_foreign_key "civicrm_participant", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_participant_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_participant", "civicrm_contact", column: "contact_id", name: "FK_civicrm_participant_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_participant", "civicrm_contact", column: "transferred_to_contact_id", name: "FK_civicrm_participant_transferred_to_contact_id", on_delete: :nullify
  add_foreign_key "civicrm_participant", "civicrm_discount", column: "discount_id", name: "FK_civicrm_participant_discount_id", on_delete: :nullify
  add_foreign_key "civicrm_participant", "civicrm_event", column: "event_id", name: "FK_civicrm_participant_event_id", on_delete: :cascade
  add_foreign_key "civicrm_participant", "civicrm_event_carts", column: "cart_id", name: "FK_civicrm_participant_cart_id", on_delete: :nullify
  add_foreign_key "civicrm_participant", "civicrm_participant", column: "registered_by_id", name: "FK_civicrm_participant_registered_by_id", on_delete: :nullify
  add_foreign_key "civicrm_participant", "civicrm_participant_status_type", column: "status_id", name: "FK_civicrm_participant_status_id"
  add_foreign_key "civicrm_participant_payment", "civicrm_contribution", column: "contribution_id", name: "FK_civicrm_participant_payment_contribution_id", on_delete: :cascade
  add_foreign_key "civicrm_participant_payment", "civicrm_participant", column: "participant_id", name: "FK_civicrm_participant_payment_participant_id", on_delete: :cascade
  add_foreign_key "civicrm_payment_processor", "civicrm_domain", column: "domain_id", name: "FK_civicrm_payment_processor_domain_id"
  add_foreign_key "civicrm_payment_processor", "civicrm_payment_processor_type", column: "payment_processor_type_id", name: "FK_civicrm_payment_processor_payment_processor_type_id"
  add_foreign_key "civicrm_payment_token", "civicrm_contact", column: "contact_id", name: "FK_civicrm_payment_token_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_payment_token", "civicrm_contact", column: "created_id", name: "FK_civicrm_payment_token_created_id", on_delete: :nullify
  add_foreign_key "civicrm_payment_token", "civicrm_payment_processor", column: "payment_processor_id", name: "FK_civicrm_payment_token_payment_processor_id"
  add_foreign_key "civicrm_pcp", "civicrm_contact", column: "contact_id", name: "FK_civicrm_pcp_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_pcp_block", "civicrm_uf_group", column: "supporter_profile_id", name: "FK_civicrm_pcp_block_supporter_profile_id", on_delete: :nullify
  add_foreign_key "civicrm_phone", "civicrm_contact", column: "contact_id", name: "FK_civicrm_phone_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_pledge", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_pledge_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_pledge", "civicrm_contact", column: "contact_id", name: "FK_civicrm_pledge_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_pledge", "civicrm_contribution_page", column: "contribution_page_id", name: "FK_civicrm_pledge_contribution_page_id", on_delete: :nullify
  add_foreign_key "civicrm_pledge", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_pledge_financial_type_id"
  add_foreign_key "civicrm_pledge_payment", "civicrm_contribution", column: "contribution_id", name: "FK_civicrm_pledge_payment_contribution_id", on_delete: :cascade
  add_foreign_key "civicrm_pledge_payment", "civicrm_pledge", column: "pledge_id", name: "FK_civicrm_pledge_payment_pledge_id", on_delete: :cascade
  add_foreign_key "civicrm_premiums_product", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_premiums_product_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_premiums_product", "civicrm_premiums", column: "premiums_id", name: "FK_civicrm_premiums_product_premiums_id"
  add_foreign_key "civicrm_premiums_product", "civicrm_product", column: "product_id", name: "FK_civicrm_premiums_product_product_id"
  add_foreign_key "civicrm_price_field", "civicrm_price_set", column: "price_set_id", name: "FK_civicrm_price_field_price_set_id"
  add_foreign_key "civicrm_price_field_value", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_price_field_value_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_price_field_value", "civicrm_membership_type", column: "membership_type_id", name: "FK_civicrm_price_field_value_membership_type_id", on_delete: :nullify
  add_foreign_key "civicrm_price_field_value", "civicrm_price_field", column: "price_field_id", name: "FK_civicrm_price_field_value_price_field_id"
  add_foreign_key "civicrm_price_set", "civicrm_domain", column: "domain_id", name: "FK_civicrm_price_set_domain_id"
  add_foreign_key "civicrm_price_set", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_price_set_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_price_set_entity", "civicrm_price_set", column: "price_set_id", name: "FK_civicrm_price_set_entity_price_set_id"
  add_foreign_key "civicrm_print_label", "civicrm_contact", column: "created_id", name: "FK_civicrm_print_label_created_id", on_delete: :nullify
  add_foreign_key "civicrm_product", "civicrm_financial_type", column: "financial_type_id", name: "FK_civicrm_product_financial_type_id", on_delete: :nullify
  add_foreign_key "civicrm_relationship", "civicrm_case", column: "case_id", name: "FK_civicrm_relationship_case_id", on_delete: :cascade
  add_foreign_key "civicrm_relationship", "civicrm_contact", column: "contact_id_a", name: "FK_civicrm_relationship_contact_id_a", on_delete: :cascade
  add_foreign_key "civicrm_relationship", "civicrm_contact", column: "contact_id_b", name: "FK_civicrm_relationship_contact_id_b", on_delete: :cascade
  add_foreign_key "civicrm_relationship", "civicrm_relationship_type", column: "relationship_type_id", name: "FK_civicrm_relationship_relationship_type_id", on_delete: :cascade
  add_foreign_key "civicrm_report_instance", "civicrm_contact", column: "created_id", name: "FK_civicrm_report_instance_created_id", on_delete: :nullify
  add_foreign_key "civicrm_report_instance", "civicrm_contact", column: "owner_id", name: "FK_civicrm_report_instance_owner_id", on_delete: :nullify
  add_foreign_key "civicrm_report_instance", "civicrm_domain", column: "domain_id", name: "FK_civicrm_report_instance_domain_id"
  add_foreign_key "civicrm_report_instance", "civicrm_navigation", column: "navigation_id", name: "FK_civicrm_report_instance_navigation_id", on_delete: :nullify
  add_foreign_key "civicrm_report_instance", "civicrm_report_instance", column: "drilldown_id", name: "FK_civicrm_report_instance_drilldown_id", on_delete: :nullify
  add_foreign_key "civicrm_saved_search", "civicrm_mapping", column: "mapping_id", name: "FK_civicrm_saved_search_mapping_id"
  add_foreign_key "civicrm_setting", "civicrm_component", column: "component_id", name: "FK_civicrm_setting_component_id"
  add_foreign_key "civicrm_setting", "civicrm_contact", column: "contact_id", name: "FK_civicrm_setting_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_setting", "civicrm_contact", column: "created_id", name: "FK_civicrm_setting_created_id", on_delete: :nullify
  add_foreign_key "civicrm_setting", "civicrm_domain", column: "domain_id", name: "FK_civicrm_setting_domain_id", on_delete: :cascade
  add_foreign_key "civicrm_sms_provider", "civicrm_domain", column: "domain_id", name: "FK_civicrm_sms_provider_domain_id", on_delete: :nullify
  add_foreign_key "civicrm_state_province", "civicrm_country", column: "country_id", name: "FK_civicrm_state_province_country_id"
  add_foreign_key "civicrm_status_pref", "civicrm_domain", column: "domain_id", name: "FK_civicrm_status_pref_domain_id"
  add_foreign_key "civicrm_subscription_history", "civicrm_contact", column: "contact_id", name: "FK_civicrm_subscription_history_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_subscription_history", "civicrm_group", column: "group_id", name: "FK_civicrm_subscription_history_group_id", on_delete: :cascade
  add_foreign_key "civicrm_survey", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_survey_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_survey", "civicrm_contact", column: "created_id", name: "FK_civicrm_survey_created_id", on_delete: :nullify
  add_foreign_key "civicrm_survey", "civicrm_contact", column: "last_modified_id", name: "FK_civicrm_survey_last_modified_id", on_delete: :nullify
  add_foreign_key "civicrm_tag", "civicrm_contact", column: "created_id", name: "FK_civicrm_tag_created_id", on_delete: :nullify
  add_foreign_key "civicrm_tag", "civicrm_tag", column: "parent_id", name: "FK_civicrm_tag_parent_id"
  add_foreign_key "civicrm_timezone", "civicrm_country", column: "country_id", name: "FK_civicrm_timezone_country_id"
  add_foreign_key "civicrm_uf_field", "civicrm_location_type", column: "location_type_id", name: "FK_civicrm_uf_field_location_type_id", on_delete: :nullify
  add_foreign_key "civicrm_uf_field", "civicrm_uf_group", column: "uf_group_id", name: "FK_civicrm_uf_field_uf_group_id", on_delete: :cascade
  add_foreign_key "civicrm_uf_group", "civicrm_contact", column: "created_id", name: "FK_civicrm_uf_group_created_id", on_delete: :nullify
  add_foreign_key "civicrm_uf_group", "civicrm_group", column: "add_to_group_id", name: "FK_civicrm_uf_group_add_to_group_id", on_delete: :nullify
  add_foreign_key "civicrm_uf_group", "civicrm_group", column: "limit_listings_group_id", name: "FK_civicrm_uf_group_limit_listings_group_id", on_delete: :nullify
  add_foreign_key "civicrm_uf_join", "civicrm_uf_group", column: "uf_group_id", name: "FK_civicrm_uf_join_uf_group_id"
  add_foreign_key "civicrm_uf_match", "civicrm_contact", column: "contact_id", name: "FK_civicrm_uf_match_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_uf_match", "civicrm_domain", column: "domain_id", name: "FK_civicrm_uf_match_domain_id"
  add_foreign_key "civicrm_value_assimilations_4", "civicrm_contact", column: "entity_id", name: "FK_civicrm_value_assimilations_4_entity_id", on_delete: :cascade
  add_foreign_key "civicrm_value_church_plant_retreat_48", "civicrm_participant", column: "entity_id", name: "FK_civicrm_value_church_plant_retreat_48_entity_id", on_delete: :cascade
  add_foreign_key "civicrm_value_civivolunteer_55", "civicrm_activity", column: "entity_id", name: "FK_civicrm_value_civivolunteer_55_entity_id", on_delete: :cascade
  add_foreign_key "civicrm_value_clear_river_series_47", "civicrm_participant", column: "entity_id", name: "FK_civicrm_value_clear_river_series_47_entity_id", on_delete: :cascade
  add_foreign_key "civicrm_value_event_fields_44", "civicrm_participant", column: "entity_id", name: "FK_civicrm_value_event_fields_44_entity_id", on_delete: :cascade
  add_foreign_key "civicrm_value_fall_area_conference_50", "civicrm_participant", column: "entity_id", name: "FK_civicrm_value_fall_area_conference_50_entity_id", on_delete: :cascade
  add_foreign_key "civicrm_value_ksa_49", "civicrm_participant", column: "entity_id", name: "FK_civicrm_value_ksa_49_entity_id", on_delete: :cascade
  add_foreign_key "civicrm_value_network_leadership_conferece_46", "civicrm_participant", column: "entity_id", name: "FK_civicrm_value_network_leadership_6056243353f2d541", on_delete: :cascade
  add_foreign_key "civicrm_value_serving_notes_16", "civicrm_contact", column: "overseer_200", name: "FK_civicrm_value_serving_notes_16_overseer_200", on_delete: :nullify
  add_foreign_key "civicrm_value_volunteer_commendation_57", "civicrm_activity", column: "entity_id", name: "FK_civicrm_value_volunteer_commenda_4144db9f68011d7f", on_delete: :cascade
  add_foreign_key "civicrm_value_volunteer_information_56", "civicrm_contact", column: "entity_id", name: "FK_civicrm_value_volunteer_informat_046a7fc5aa1e0415", on_delete: :cascade
  add_foreign_key "civicrm_volunteer_need", "civicrm_volunteer_project", column: "project_id", name: "FK_civicrm_volunteer_need_project_id", on_delete: :nullify
  add_foreign_key "civicrm_volunteer_project", "civicrm_campaign", column: "campaign_id", name: "FK_civicrm_volunteer_project_campaign_id", on_delete: :nullify
  add_foreign_key "civicrm_volunteer_project", "civicrm_loc_block", column: "loc_block_id", name: "FK_civicrm_volunteer_project_loc_block_id", on_delete: :nullify
  add_foreign_key "civicrm_volunteer_project_contact", "civicrm_contact", column: "contact_id", name: "FK_civicrm_volunteer_project_contact_contact_id", on_delete: :cascade
  add_foreign_key "civicrm_volunteer_project_contact", "civicrm_volunteer_project", column: "project_id", name: "FK_civicrm_volunteer_project_contact_project_id", on_delete: :cascade
  add_foreign_key "civicrm_website", "civicrm_contact", column: "contact_id", name: "FK_civicrm_website_contact_id", on_delete: :cascade
end
