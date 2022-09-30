# frozen_string_literal: true

class CreateTeamUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :team_users do |t|
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
