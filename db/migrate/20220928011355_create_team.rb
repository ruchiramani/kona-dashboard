# frozen_string_literal: true

class CreateTeam < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.references :org, foreign_key: true
      t.string :slack_team_id
      t.timestamps
    end
  end
end
