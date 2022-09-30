# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

filepath = File.join(Rails.root, 'lib', 'assets', 'data.csv')
CSV.foreach(filepath) do |row|
  org = Org.find_or_create_by(slack_org_id: row[10])
  team = Team.find_or_create_by(slack_team_id: row[11], org_id: org.id)
  user = User.find_or_create_by(slack_user_id: row[12])
  team_user = TeamUser.find_or_create_by(team_id: team.id, user_id: user.id)
  CheckIn.create(team_user_id: team_user.id, slack_created_at: Time.at(row[1].to_i), elaboration: row[2], private_elaboration: row[6], emotion: row[3],
                 meeting_hours: row[4], platform: row[5], reactions: row[7], selection: row[8], slack_message_id: row[9])
end

#    0 Id
#    1 Timestamp
#    2 Elaboration
#    3 Emotion
#    4 MeetingHours
#    5 Platform
#    6 PrivateElaboration
#    7 Reactions
#    8 Selection
#    9 SlackMessageId
#    10 SlackOrgId
#    11 SlackTeamId
#    12 SlackUserId
