# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :team_users
  has_many :teams, through: :team_users
end
