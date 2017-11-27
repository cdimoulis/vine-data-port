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

ActiveRecord::Schema.define(version: 20170829201304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "f1_address_types", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_address_types", ["name"], name: "index_f1_address_types_on_name", using: :btree

  create_table "f1_addresses", force: :cascade do |t|
    t.string   "uri"
    t.integer  "household_id"
    t.integer  "person_id"
    t.integer  "address_type_id"
    t.text     "address1"
    t.text     "address2"
    t.text     "address3"
    t.string   "city"
    t.string   "postal_code"
    t.string   "county"
    t.string   "country"
    t.string   "st_province"
    t.string   "carrier_route"
    t.string   "delivery_point"
    t.datetime "address_date"
    t.text     "address_comment"
    t.boolean  "usps_verified"
    t.datetime "address_verified_date"
    t.datetime "last_verification_attempt_date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "f1_addresses", ["address_type_id"], name: "index_f1_addresses_on_address_type_id", using: :btree
  add_index "f1_addresses", ["household_id"], name: "index_f1_addresses_on_household_id", using: :btree
  add_index "f1_addresses", ["person_id"], name: "index_f1_addresses_on_person_id", using: :btree

  create_table "f1_attribute_groups", force: :cascade do |t|
    t.string  "uri"
    t.integer "old_id"
    t.string  "name"
  end

  add_index "f1_attribute_groups", ["name"], name: "index_f1_attribute_groups_on_name", using: :btree

  create_table "f1_attributes", force: :cascade do |t|
    t.string  "uri"
    t.integer "old_id"
    t.string  "name"
    t.integer "attribute_group_id"
  end

  add_index "f1_attributes", ["attribute_group_id"], name: "index_f1_attributes_on_attribute_group_id", using: :btree
  add_index "f1_attributes", ["name"], name: "index_f1_attributes_on_name", using: :btree

  create_table "f1_background_check_statuses", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_background_check_statuses", ["name"], name: "index_f1_background_check_statuses_on_name", using: :btree

  create_table "f1_batch_statuses", force: :cascade do |t|
    t.string "uri"
    t.string "name"
  end

  add_index "f1_batch_statuses", ["name"], name: "index_f1_batch_statuses_on_name", using: :btree

  create_table "f1_batch_types", force: :cascade do |t|
    t.string "uri"
    t.string "name"
  end

  add_index "f1_batch_types", ["name"], name: "index_f1_batch_types_on_name", using: :btree

  create_table "f1_batches", force: :cascade do |t|
    t.string   "uri"
    t.integer  "old_id"
    t.string   "name"
    t.float    "amount"
    t.integer  "batch_type_id"
    t.integer  "batch_status_id"
    t.datetime "batch_date"
    t.datetime "received_date"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "f1_batches", ["batch_status_id"], name: "index_f1_batches_on_batch_status_id", using: :btree
  add_index "f1_batches", ["batch_type_id"], name: "index_f1_batches_on_batch_type_id", using: :btree

  create_table "f1_campuses", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_campuses", ["name"], name: "index_f1_campuses_on_name", using: :btree

  create_table "f1_categories", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_categories", ["name"], name: "index_f1_categories_on_name", using: :btree

  create_table "f1_categories_groups", force: :cascade do |t|
    t.integer "category_id"
    t.integer "group_id"
  end

  add_index "f1_categories_groups", ["category_id"], name: "index_f1_categories_groups_on_category_id", using: :btree
  add_index "f1_categories_groups", ["group_id"], name: "index_f1_categories_groups_on_group_id", using: :btree

  create_table "f1_communication_types", force: :cascade do |t|
    t.string "uri"
    t.string "general_type"
    t.string "name"
  end

  add_index "f1_communication_types", ["name"], name: "index_f1_communication_types_on_name", using: :btree

  create_table "f1_communications", force: :cascade do |t|
    t.string   "uri"
    t.integer  "household_id"
    t.integer  "person_id"
    t.integer  "communication_type_id"
    t.string   "communication_general_type"
    t.string   "communication_value"
    t.string   "search_communication_value"
    t.boolean  "preferred"
    t.text     "communication_comment"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "f1_communications", ["communication_type_id"], name: "index_f1_communications_on_communication_type_id", using: :btree
  add_index "f1_communications", ["household_id"], name: "index_f1_communications_on_household_id", using: :btree
  add_index "f1_communications", ["person_id"], name: "index_f1_communications_on_person_id", using: :btree

  create_table "f1_contribution_receipts", force: :cascade do |t|
    t.string   "uri"
    t.integer  "old_id"
    t.float    "amount"
    t.integer  "fund_id"
    t.integer  "sub_fund_id"
    t.integer  "pledge_drive_id"
    t.integer  "household_id"
    t.integer  "person_id"
    t.integer  "account_id"
    t.integer  "reference_image_id"
    t.integer  "batch_id"
    t.integer  "activity_instance_id"
    t.integer  "contribution_type_id"
    t.integer  "contribution_sub_type_id"
    t.datetime "received_date"
    t.datetime "transmit_date"
    t.datetime "return_date"
    t.datetime "retransmit_date"
    t.datetime "gl_post_date"
    t.boolean  "is_split"
    t.boolean  "address_verification"
    t.text     "memo"
    t.string   "stated_value"
    t.string   "true_value"
    t.boolean  "thank"
    t.datetime "thanked_date"
    t.boolean  "is_matched"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "f1_contribution_receipts", ["account_id"], name: "index_f1_contribution_receipts_on_account_id", using: :btree
  add_index "f1_contribution_receipts", ["activity_instance_id"], name: "index_f1_contribution_receipts_on_activity_instance_id", using: :btree
  add_index "f1_contribution_receipts", ["batch_id"], name: "index_f1_contribution_receipts_on_batch_id", using: :btree
  add_index "f1_contribution_receipts", ["contribution_sub_type_id"], name: "index_f1_contribution_receipts_on_contribution_sub_type_id", using: :btree
  add_index "f1_contribution_receipts", ["contribution_type_id"], name: "index_f1_contribution_receipts_on_contribution_type_id", using: :btree
  add_index "f1_contribution_receipts", ["fund_id"], name: "index_f1_contribution_receipts_on_fund_id", using: :btree
  add_index "f1_contribution_receipts", ["household_id"], name: "index_f1_contribution_receipts_on_household_id", using: :btree
  add_index "f1_contribution_receipts", ["person_id"], name: "index_f1_contribution_receipts_on_person_id", using: :btree
  add_index "f1_contribution_receipts", ["pledge_drive_id"], name: "index_f1_contribution_receipts_on_pledge_drive_id", using: :btree
  add_index "f1_contribution_receipts", ["reference_image_id"], name: "index_f1_contribution_receipts_on_reference_image_id", using: :btree
  add_index "f1_contribution_receipts", ["sub_fund_id"], name: "index_f1_contribution_receipts_on_sub_fund_id", using: :btree

  create_table "f1_contribution_sub_types", force: :cascade do |t|
    t.string  "uri"
    t.string  "name"
    t.integer "contribution_type_id"
  end

  add_index "f1_contribution_sub_types", ["contribution_type_id"], name: "index_f1_contribution_sub_types_on_contribution_type_id", using: :btree

  create_table "f1_contribution_types", force: :cascade do |t|
    t.string "uri"
    t.string "name"
  end

  add_index "f1_contribution_types", ["name"], name: "index_f1_contribution_types_on_name", using: :btree

  create_table "f1_date_range_types", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_date_range_types", ["name"], name: "index_f1_date_range_types_on_name", using: :btree

  create_table "f1_denominations", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_denominations", ["name"], name: "index_f1_denominations_on_name", using: :btree

  create_table "f1_events", force: :cascade do |t|
    t.string   "uri"
    t.string   "name"
    t.text     "description"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "f1_events", ["created_by_id"], name: "index_f1_events_on_created_by_id", using: :btree
  add_index "f1_events", ["updated_by_id"], name: "index_f1_events_on_updated_by_id", using: :btree

  create_table "f1_fund_types", force: :cascade do |t|
    t.string "uri"
    t.string "name"
  end

  add_index "f1_fund_types", ["name"], name: "index_f1_fund_types_on_name", using: :btree

  create_table "f1_funds", force: :cascade do |t|
    t.string   "uri"
    t.integer  "old_id"
    t.string   "name"
    t.integer  "fund_type_id"
    t.string   "fund_code"
    t.boolean  "is_web_enabled"
    t.boolean  "is_active"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "f1_funds", ["fund_type_id"], name: "index_f1_funds_on_fund_type_id", using: :btree

  create_table "f1_genders", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_genders", ["name"], name: "index_f1_genders_on_name", using: :btree

  create_table "f1_group_types", force: :cascade do |t|
    t.string   "name"
    t.string   "uri"
    t.string   "description"
    t.boolean  "is_web_enabled"
    t.boolean  "is_searchable"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "f1_group_types", ["name"], name: "index_f1_group_types_on_name", using: :btree

  create_table "f1_groups", force: :cascade do |t|
    t.string   "uri"
    t.string   "name"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "expiration_date"
    t.boolean  "is_open"
    t.boolean  "is_public"
    t.boolean  "has_childcare"
    t.boolean  "is_searchable"
    t.integer  "campus_id"
    t.integer  "group_type_id"
    t.string   "group_url"
    t.integer  "timezone_id"
    t.integer  "gender_id"
    t.integer  "marital_status_id"
    t.string   "start_age_range"
    t.string   "end_age_range"
    t.integer  "date_range_type_id"
    t.string   "leaders_count"
    t.string   "members_count"
    t.string   "open_prospects_count"
    t.integer  "event_id"
    t.integer  "location_id"
    t.boolean  "is_location_private"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "f1_groups", ["campus_id"], name: "index_f1_groups_on_campus_id", using: :btree
  add_index "f1_groups", ["date_range_type_id"], name: "index_f1_groups_on_date_range_type_id", using: :btree
  add_index "f1_groups", ["event_id"], name: "index_f1_groups_on_event_id", using: :btree
  add_index "f1_groups", ["gender_id"], name: "index_f1_groups_on_gender_id", using: :btree
  add_index "f1_groups", ["group_type_id"], name: "index_f1_groups_on_group_type_id", using: :btree
  add_index "f1_groups", ["location_id"], name: "index_f1_groups_on_location_id", using: :btree
  add_index "f1_groups", ["marital_status_id"], name: "index_f1_groups_on_marital_status_id", using: :btree
  add_index "f1_groups", ["timezone_id"], name: "index_f1_groups_on_timezone_id", using: :btree

  create_table "f1_household_member_types", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_household_member_types", ["name"], name: "index_f1_household_member_types_on_name", using: :btree

  create_table "f1_households", force: :cascade do |t|
    t.string   "uri"
    t.integer  "old_id"
    t.string   "h_code"
    t.string   "household_name"
    t.string   "household_sort_name"
    t.string   "household_first_name"
    t.datetime "last_security_authorization"
    t.datetime "last_activity_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "f1_households", ["household_first_name"], name: "index_f1_households_on_household_first_name", using: :btree
  add_index "f1_households", ["household_name"], name: "index_f1_households_on_household_name", using: :btree
  add_index "f1_households", ["household_sort_name"], name: "index_f1_households_on_household_sort_name", using: :btree

  create_table "f1_locations", force: :cascade do |t|
    t.string   "uri"
    t.string   "name"
    t.string   "description"
    t.integer  "event_id"
    t.boolean  "is_online"
    t.string   "url"
    t.json     "address"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "f1_locations", ["event_id"], name: "index_f1_locations_on_event_id", using: :btree

  create_table "f1_marital_statuses", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_marital_statuses", ["name"], name: "index_f1_marital_statuses_on_name", using: :btree

  create_table "f1_member_types", force: :cascade do |t|
    t.string   "uri"
    t.string   "name"
    t.text     "description"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "f1_occupations", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_occupations", ["name"], name: "index_f1_occupations_on_name", using: :btree

  create_table "f1_people", force: :cascade do |t|
    t.string   "uri"
    t.string   "image_uri"
    t.integer  "old_id"
    t.string   "i_code"
    t.integer  "household_id"
    t.integer  "old_household_id"
    t.string   "title"
    t.string   "salutation"
    t.string   "prefix"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "middle_name"
    t.string   "goes_by_name"
    t.string   "former_name"
    t.integer  "gender_id"
    t.date     "date_of_birth"
    t.string   "marital_status"
    t.integer  "household_member_type_id"
    t.boolean  "is_authorized"
    t.integer  "status_id"
    t.integer  "occupation_id"
    t.string   "employer"
    t.integer  "school_id"
    t.integer  "denomination_id"
    t.string   "former_church"
    t.string   "bar_code"
    t.string   "member_envelope_code"
    t.string   "default_tag_comment"
    t.json     "weblink"
    t.string   "solicit"
    t.boolean  "thank"
    t.datetime "first_record"
    t.datetime "last_match_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "f1_people", ["denomination_id"], name: "index_f1_people_on_denomination_id", using: :btree
  add_index "f1_people", ["gender_id"], name: "index_f1_people_on_gender_id", using: :btree
  add_index "f1_people", ["household_id"], name: "index_f1_people_on_household_id", using: :btree
  add_index "f1_people", ["household_member_type_id"], name: "index_f1_people_on_household_member_type_id", using: :btree
  add_index "f1_people", ["occupation_id"], name: "index_f1_people_on_occupation_id", using: :btree
  add_index "f1_people", ["school_id"], name: "index_f1_people_on_school_id", using: :btree

  create_table "f1_people_requirements", force: :cascade do |t|
    t.string   "uri"
    t.string   "requirement_document_uri"
    t.integer  "person_id"
    t.integer  "requirement_id"
    t.integer  "requirement_status_id"
    t.datetime "requirement_date"
    t.integer  "staff_id"
    t.integer  "background_check_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "f1_people_requirements", ["background_check_id"], name: "index_f1_people_requirements_on_background_check_id", using: :btree
  add_index "f1_people_requirements", ["person_id"], name: "index_f1_people_requirements_on_person_id", using: :btree
  add_index "f1_people_requirements", ["requirement_id"], name: "index_f1_people_requirements_on_requirement_id", using: :btree
  add_index "f1_people_requirements", ["requirement_status_id"], name: "index_f1_people_requirements_on_requirement_status_id", using: :btree
  add_index "f1_people_requirements", ["staff_id"], name: "index_f1_people_requirements_on_staff_id", using: :btree

  create_table "f1_recurrence_types", force: :cascade do |t|
    t.string "uri"
    t.string "name"
  end

  create_table "f1_requirement_statuses", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_requirement_statuses", ["name"], name: "index_f1_requirement_statuses_on_name", using: :btree

  create_table "f1_requirements", force: :cascade do |t|
    t.string   "uri"
    t.string   "old_id"
    t.string   "name"
    t.boolean  "is_active"
    t.boolean  "has_document"
    t.boolean  "is_confidential"
    t.boolean  "is_background_check"
    t.boolean  "is_reference_check"
    t.integer  "quantity"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "f1_requirements", ["name"], name: "index_f1_requirements_on_name", using: :btree

  create_table "f1_schedules", force: :cascade do |t|
    t.string   "uri"
    t.string   "name"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "number_recurrences"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "recurrence_type_id"
    t.json     "recurrences"
    t.integer  "event_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "f1_schedules", ["event_id"], name: "index_f1_schedules_on_event_id", using: :btree
  add_index "f1_schedules", ["recurrence_type_id"], name: "index_f1_schedules_on_recurrence_type_id", using: :btree

  create_table "f1_schools", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_schools", ["name"], name: "index_f1_schools_on_name", using: :btree

  create_table "f1_statuses", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

  add_index "f1_statuses", ["name"], name: "index_f1_statuses_on_name", using: :btree

  create_table "f1_sub_funds", force: :cascade do |t|
    t.string   "uri"
    t.integer  "old_id"
    t.integer  "fund_id"
    t.string   "name"
    t.string   "general_ledger"
    t.string   "sub_fund_code"
    t.boolean  "is_web_enabled"
    t.boolean  "is_active"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "f1_sub_funds", ["fund_id"], name: "index_f1_sub_funds_on_fund_id", using: :btree

  create_table "f1_sub_statuses", force: :cascade do |t|
    t.string "name"
    t.string "uri"
    t.string "status_id"
  end

  add_index "f1_sub_statuses", ["name"], name: "index_f1_sub_statuses_on_name", using: :btree
  add_index "f1_sub_statuses", ["status_id"], name: "index_f1_sub_statuses_on_status_id", using: :btree

  create_table "f1_timezones", force: :cascade do |t|
    t.string "name"
    t.string "uri"
  end

end
