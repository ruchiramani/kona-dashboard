# frozen_string_literal: true

class Org < ActiveRecord::Base
  has_many :teams
  has_many :team_users, through: :teams
end
