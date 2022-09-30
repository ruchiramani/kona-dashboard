# frozen_string_literal: true

class TeamController < ApplicationController
  protect_from_forgery with: :null_session

  def weekly_overview
    org = Team.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    check_ins = CheckIn.where(team_user_id: team_user_ids).where('slack_created_at >= ?', '2022-03-01').where(
      'slack_created_at < ?', '2022-03-08'
    )
    start = '01/03/2022'
    finish = '07/03/2022'
    sanitized_data = { 'date' => [], 'green' => [], 'yellow' => [], 'red' => [] }
    dates = (start.to_date..finish.to_date).map(&:to_s)
    dates.each do |date|
      sanitized_data['date'] << date
      sanitized_data['green'] << check_ins.where(selection: 'green').where(
        "date_trunc('day', slack_created_at) = ?", date
      ).count
      sanitized_data['yellow'] << check_ins.where(selection: 'yellow').where(
        "date_trunc('day', slack_created_at) = ?", date
      ).count
      sanitized_data['red'] << check_ins.where(selection: 'red').where("date_trunc('day', slack_created_at) = ?",
                                                                       date).count
    end
    render json: sanitized_data
  end

  def most_active_user
    org = Team.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    CheckIn.where(team_user_id: team_user_ids).group(:team_user_id).order(count: :desc).limit(5).count
  end

  def most_inactive_user
    #   # tip: reach out to them, nudge them to share
    org = Team.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    CheckIn.where(team_user_id: team_user_ids).group(:team_user_id).order(count: :asc).limit(5).count
  end

  def red_alert_user
    org = Team.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    CheckIn.where(team_user_id: team_user_ids).where(selection: 'red').group(:team_user_id).order(count: :desc).limit(5).count
    # the user with the most amount of red check-ins
  end

  def top_emotion_weekly
    org = Team.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    CheckIn.where(team_user_id: team_user_ids).group(:emotion).order(count: :desc).limit(5).count
  end

  def team_check_alert
    # more than 50% of the team is reported red or yellow this week
    org = Team.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    CheckIn.includes(:team_user).references(:team_users).where(team_user_id: team_user_ids).where(selection: 'red').group('team_users.team_id').order(count: :desc).limit(5).count
  end
end
