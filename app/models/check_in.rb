# frozen_string_literal: true

class CheckIn < ActiveRecord::Base
  enum selection: %i[green yellow red]
  belongs_to :team_user
end
