# frozen_string_literal: true

class CreateOrg < ActiveRecord::Migration[7.0]
  def change
    create_table :orgs do |t|
      t.string :slack_org_id
      t.timestamps
    end
  end
end
