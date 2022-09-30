# frozen_string_literal: true

class TeamUser < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :check_ins
end
