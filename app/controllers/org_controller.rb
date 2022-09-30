# frozen_string_literal: true

class OrgController < ApplicationController
  protect_from_forgery with: :null_session

  START_DATE = '2022-03-07'
  END_DATE = '2022-03-14'

  def weekly_overview
    org = Org.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    sanitized_data = { 'date' => [], 'green' => [], 'yellow' => [], 'red' => [] }
    dates = (START_DATE.to_date..END_DATE.to_date).map(&:to_s)
    dates.each do |date|
      sanitized_data['date'] << date
      sanitized_data['green'] << CheckIn.where(team_user_id: team_user_ids).where(selection: 'green').where(
        "date_trunc('day', slack_created_at) = ?", date
      ).count
      sanitized_data['yellow'] << CheckIn.where(team_user_id: team_user_ids).where(selection: 'yellow').where(
        "date_trunc('day', slack_created_at) = ?", date
      ).count
      sanitized_data['red'] << CheckIn.where(team_user_id: team_user_ids).where(selection: 'red').where(
        "date_trunc('day', slack_created_at) = ?", date
      ).count
    end
    render json: sanitized_data
  end

  def weekly_breakdown
    org = Org.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    check_ins = CheckIn.where(team_user_id: team_user_ids).where('slack_created_at >= ?', START_DATE).where(
      'slack_created_at < ?', END_DATE
    ).group(:selection).count
    sanitized_data = []
    sanitized_data << check_ins['green']
    sanitized_data << check_ins['yellow']
    sanitized_data << check_ins['red']
    render json: sanitized_data
  end

  def green_team
    org = Org.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    check_ins = CheckIn.includes(:team_user).references(:team_users).where(team_user_id: team_user_ids).where('slack_created_at >= ?', START_DATE).where(
      'slack_created_at < ?', END_DATE
    ).where(selection: 'green').group('team_users.team_id').order(count: :desc).limit(1).count
    team_slack_id = Team.find(check_ins.first[0]).slack_team_id
    data = {
      teamId: team_slack_id,
      numberOfCheckIns: check_ins.first[1]
    }

    render json: data
  end

  def red_team
    org = Org.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    check_ins = CheckIn.includes(:team_user).references(:team_users).where(team_user_id: team_user_ids).where('slack_created_at >= ?', START_DATE).where(
      'slack_created_at < ?', END_DATE
    ).where(selection: 'red').group('team_users.team_id').order(count: :desc).limit(1).count
    team_slack_id = Team.find(check_ins.first[0]).slack_team_id
    data = {
      teamId: team_slack_id,
      numberOfCheckIns: check_ins.first[1]
    }

    render json: data
  end

  def top_emotions
    org = Org.find(params[:id].to_i)
    team_user_ids = org.team_users.pluck(:id)
    check_ins = CheckIn.where(team_user_id: team_user_ids).where('slack_created_at >= ?', START_DATE).where(
      'slack_created_at < ?', END_DATE
    ).where('emotion IS NOT NULL').group(:emotion).order(count: :desc).limit(3).count

    render json: check_ins
  end
end
