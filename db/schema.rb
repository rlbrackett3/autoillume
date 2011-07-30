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

ActiveRecord::Schema.define(:version => 20110730055309) do

  create_table "admins", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["username"], :name => "index_admins_on_username", :unique => true

  create_table "bios", :force => true do |t|
    t.string   "name"
    t.string   "handle"
    t.text     "description"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "external_links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "link_order",  :default => 0
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_order", :default => 0
  end

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.integer  "width"
    t.integer  "height"
    t.string   "orientation"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.string   "state"
    t.datetime "published_at"
  end

  add_index "posts", ["admin_id"], :name => "index_posts_on_admin_id"

  create_table "replies", :force => true do |t|
    t.text     "body"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
  end

  create_table "sections", :force => true do |t|
    t.text     "body"
    t.integer  "position",     :default => 0
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "section_type"
  end

end
