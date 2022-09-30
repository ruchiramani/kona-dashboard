# frozen_string_literal: true

class CreateCheckIn < ActiveRecord::Migration[7.0]
  def change
    create_table :check_ins do |t|
      t.references :team_user, foreign_key: true
      t.string :emotion
      t.string :elaboration
      t.string :private_elaboration
      t.decimal :meeting_hours
      t.string :platform
      t.json :reactions
      t.integer :selection
      t.string :slack_message_id
      t.datetime :slack_created_at
      t.timestamps
    end
  end
end
