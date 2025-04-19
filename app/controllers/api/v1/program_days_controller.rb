class Api::V1::ProgramDaysController < ApplicationController
  before_action :set_user
  before_action :set_day, only: [:activities]

  def index
    render json: ProgramDay.all
  end

  def activities
    activities = fetch_user_activities_for_day

    render json: {
      day: @day.day_number,
      activities_remaining: activities.where(completed: false).count,
      activities: activities.map { |pda| format_activity(pda) }
    }
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    render json: { error: "User not found" }, status: :not_found unless @user
  end

  def set_day
    @day = ProgramDay.find_by(day_number: params[:day_number])
    render json: { error: "Day not found" }, status: :not_found unless @day
  end

  def fetch_user_activities_for_day
    ProgramDayActivity
      .includes(:activity)
      .where(program_day: @day, user_id: @user.id)
  end

  def format_activity(pda)
    {
      id: pda.id,
      title: pda.activity.title,
      frequency: pda.activity.frequency,
      completed: pda.completed
    }
  end
end
