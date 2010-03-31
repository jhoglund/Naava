# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100331122549) do

  create_table "attendants", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "session_id"
    t.integer  "status"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bankgiros", :force => true do |t|
    t.integer  "avinr"
    t.integer  "gross"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", :force => true do |t|
    t.integer  "booker_id"
    t.string   "booker_type"
    t.integer  "participant_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",         :default => 0
  end

  create_table "cashes", :force => true do |t|
    t.integer  "gross"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupon_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", :force => true do |t|
    t.string   "to_name"
    t.string   "to_email"
    t.string   "to_phone"
    t.string   "to_address"
    t.string   "from_name"
    t.string   "from_email"
    t.string   "from_phone"
    t.string   "from_address"
    t.text     "message"
    t.string   "token"
    t.integer  "coupon_type_id"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",        :default => 0
    t.integer  "instructor_id"
    t.text     "comment"
  end

  create_table "frees", :force => true do |t|
    t.integer  "reference_id"
    t.string   "reference_type"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "bio"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "participants", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "note"
    t.text     "meta"
    t.string   "token"
    t.integer  "value",        :default => 0
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "reciept_id"
    t.string   "reciept_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paypal_reciepts", :force => true do |t|
    t.string   "transaction_id"
    t.float    "gross"
    t.float    "fee"
    t.string   "currency"
    t.string   "item_name"
    t.string   "status"
    t.string   "type"
    t.string   "custom"
    t.string   "pending_reason"
    t.string   "reason_code"
    t.text     "memo"
    t.string   "payment_type"
    t.float    "exchange_rate"
    t.datetime "received_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_reciept_id"
  end

  create_table "sessions", :force => true do |t|
    t.integer  "course_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     :default => 1
    t.text     "comment"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login",                              :null => false
    t.string   "phone"
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
