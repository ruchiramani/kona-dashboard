# frozen_string_literal: true

class Team < ActiveRecord::Base
  has_many :team_users
  has_many :users, through: :team_users
  belongs_to :org
end
