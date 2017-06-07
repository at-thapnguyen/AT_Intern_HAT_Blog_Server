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

ActiveRecord::Schema.define(version: 20170523085143) do

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",     limit: 65535
    t.string   "title_image"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "count_like",                default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "deleted"
    t.string   "slug"
    t.index ["category_id"], name: "fk_rails_af09d53ead", using: :btree
    t.index ["slug"], name: "index_articles_on_slug", using: :btree
    t.index ["user_id"], name: "fk_rails_3d31dad1cc", using: :btree
  end

  create_table "articles_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "article_id"
    t.integer "tag_id"
    t.index ["article_id"], name: "fk_rails_74380b8667", using: :btree
    t.index ["tag_id"], name: "fk_rails_d3e30c5d45", using: :btree
  end

  create_table "attentions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "article_id"
    t.integer "user_id"
    t.boolean "isLiked",    default: false
    t.boolean "isFollowed", default: false
    t.index ["article_id"], name: "fk_rails_f8c0064c5c", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.boolean "deleted", default: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["article_id"], name: "fk_rails_3bf61a60d3", using: :btree
    t.index ["user_id"], name: "fk_rails_03de2dc08c", using: :btree
  end

  create_table "follow_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "follower_id"
    t.boolean "isChecked",   default: false
    t.index ["user_id"], name: "fk_rails_6bfac4ba98", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "notificationable_id"
    t.string   "notificationable_type"
    t.integer  "user_id"
    t.string   "message"
    t.string   "image"
    t.boolean  "isChecked",             default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.boolean "deleted", default: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fullname"
    t.string   "username"
    t.string   "email"
    t.string   "avatar"
    t.string   "description"
    t.string   "password_digest"
    t.string   "access_token"
    t.string   "confirm_token"
    t.date     "birthday"
    t.boolean  "access",          default: false
    t.boolean  "blocked",         default: true
    t.boolean  "email_confirmed", default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "users"
  add_foreign_key "articles_tags", "articles"
  add_foreign_key "articles_tags", "tags"
  add_foreign_key "attentions", "articles"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "users"
  add_foreign_key "follow_users", "users"
end
