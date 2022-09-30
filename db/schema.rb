# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_928_011_445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'check_ins', force: :cascade do |t|
    t.bigint 'team_user_id'
    t.string 'emotion'
    t.string 'elaboration'
    t.string 'private_elaboration'
    t.decimal 'meeting_hours'
    t.string 'platform'
    t.json 'reactions'
    t.integer 'selection'
    t.string 'slack_message_id'
    t.datetime 'slack_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['team_user_id'], name: 'index_check_ins_on_team_user_id'
  end

  create_table 'orgs', force: :cascade do |t|
    t.string 'slack_org_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'team_users', force: :cascade do |t|
    t.bigint 'team_id'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['team_id'], name: 'index_team_users_on_team_id'
    t.index ['user_id'], name: 'index_team_users_on_user_id'
  end

  create_table 'teams', force: :cascade do |t|
    t.bigint 'org_id'
    t.string 'slack_team_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['org_id'], name: 'index_teams_on_org_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'slack_user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'check_ins', 'team_users'
  add_foreign_key 'team_users', 'teams'
  add_foreign_key 'team_users', 'users'
  add_foreign_key 'teams', 'orgs'
end
