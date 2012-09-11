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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "address", :force => true do |t|
    t.string   "street1",     :limit => 50, :null => false
    t.string   "street2",     :limit => 50
    t.string   "city",        :limit => 50, :null => false
    t.string   "state",       :limit => 5,  :null => false
    t.string   "zip_code",    :limit => 20, :null => false
    t.datetime "create_date",               :null => false
    t.datetime "modify_date"
    t.integer  "status",      :limit => 1,  :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "name",           :limit => 80, :null => false
    t.string   "home_phone",     :limit => 20
    t.string   "mobile_phone",   :limit => 20
    t.string   "business_phone", :limit => 20
    t.string   "fax",            :limit => 20
    t.string   "email",          :limit => 80
    t.datetime "create_date",                  :null => false
    t.datetime "modify_date"
    t.integer  "status",         :limit => 1,  :null => false
  end

  create_table "customers_address", :force => true do |t|
    t.integer  "customer_id", :limit => 3,                 :null => false
    t.string   "address_id",  :limit => 40,                :null => false
    t.integer  "is_primary",  :limit => 1,  :default => 1, :null => false
    t.datetime "create_date",                              :null => false
    t.datetime "modify_date",                              :null => false
    t.integer  "status",      :limit => 1,                 :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "order_number",   :limit => 10,                 :null => false
    t.string   "item_number",    :limit => 10,                 :null => false
    t.integer  "quantity",       :limit => 1
    t.string   "wood",           :limit => 100
    t.string   "finish"
    t.string   "description"
    t.string   "image_uri",                                    :null => false
    t.float    "price"
    t.float    "finishing_cost"
    t.datetime "create_date",                                  :null => false
    t.integer  "status",         :limit => 1,   :default => 1, :null => false
  end

  add_index "items", ["image_uri"], :name => "image_uri", :unique => true
  add_index "items", ["order_number"], :name => "FK_items_orders"

  create_table "ledger", :force => true do |t|
    t.string   "order_number",   :limit => 50, :null => false
    t.string   "payment_type",   :limit => 20, :null => false
    t.string   "payment_method", :limit => 20, :null => false
    t.float    "amount",                       :null => false
    t.datetime "payment_date",                 :null => false
    t.integer  "status",         :limit => 1,  :null => false
  end

  create_table "note", :force => true do |t|
    t.string   "order_number", :limit => 20,  :null => false
    t.string   "note_type",    :limit => 40,  :null => false
    t.text     "content",      :limit => 255, :null => false
    t.datetime "create_date",                 :null => false
    t.datetime "modify_date",                 :null => false
    t.integer  "status",       :limit => 1,   :null => false
  end

  add_index "note", ["order_number"], :name => "FK_note_orders"

  create_table "orders", :force => true do |t|
    t.string   "order_number",    :limit => 10,  :null => false
    t.integer  "customer_id",     :limit => 3,   :null => false
    t.string   "address_id",      :limit => 128, :null => false
    t.string   "lead_source"
    t.string   "delivery_option", :limit => 80
    t.float    "price"
    t.float    "finishing"
    t.float    "discount"
    t.float    "delivery_charge"
    t.float    "sales_tax"
    t.datetime "order_date",                     :null => false
    t.integer  "estimated_time",  :limit => 1,   :null => false
    t.date     "delivery_date"
    t.integer  "status",          :limit => 1,   :null => false
  end

  add_index "orders", ["order_number"], :name => "order_number", :unique => true

  create_table "payment_type", :primary_key => "name", :force => true do |t|
    t.string "description", :limit => 40, :null => false
  end

  create_table "role", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  create_table "states", :id => false, :force => true do |t|
    t.string "name",         :limit => 50, :null => false
    t.string "abbreviation", :limit => 2,  :null => false
  end

  create_table "stores", :id => false, :force => true do |t|
    t.string  "name",         :limit => 50, :null => false
    t.string  "code",         :limit => 10, :null => false
    t.integer "store_number", :limit => 2,  :null => false
    t.string  "street1",      :limit => 40, :null => false
    t.string  "street2",      :limit => 40, :null => false
    t.string  "city",         :limit => 40, :null => false
    t.string  "state",        :limit => 5,  :null => false
    t.string  "zip_code",     :limit => 10, :null => false
    t.string  "phone",        :limit => 20, :null => false
    t.string  "fax",          :limit => 20, :null => false
    t.integer "order_number", :limit => 2,  :null => false
    t.float   "sales_tax",                  :null => false
  end

  create_table "user", :force => true do |t|
    t.string   "name",        :limit => 40, :null => false
    t.datetime "create_date",               :null => false
    t.datetime "modify_date",               :null => false
    t.integer  "status",      :limit => 1,  :null => false
  end

  create_table "user_role", :force => true do |t|
    t.string   "user_id",     :limit => 40, :null => false
    t.integer  "role_id",     :limit => 1,  :null => false
    t.datetime "create_date",               :null => false
    t.datetime "modify_date",               :null => false
    t.integer  "status",      :limit => 1,  :null => false
  end

  add_index "user_role", ["role_id"], :name => "FK_user_role_role"
  add_index "user_role", ["user_id"], :name => "FK_user_role_user"

end
