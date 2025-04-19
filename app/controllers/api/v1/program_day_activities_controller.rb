class Api::V1::ProgramDayActivitiesController < ApplicationController
  before_action :set_program_day_activity
  before_action :set_current_program_day

  def complete
    if activity_day_number > @current_program_day
      render json: {
        success: false,
        error: "Cannot complete a future activity. Today is day #{@current_program_day}, this activity is for day #{activity_day_number}."
      }, status: :unprocessable_entity
      return
    end

    mark_activity_as_completed
    render json: completion_response
  end

  private

  def set_program_day_activity
    @program_day_activity = ProgramDayActivity.find(params[:id])
  end

  def set_current_program_day
    start_date = @program_day_activity.program_start_date.to_date
    @current_program_day = (Date.today - start_date).to_i + 1
  end

  def mark_activity_as_completed
    @program_day_activity.update(completed: true)
  end

  def activity_day_number
    @program_day_activity.program_day.day_number
  end

  def completed_late?
    activity_day_number < @current_program_day
  end

  def completion_message
    if completed_late?
      "Activity completed late. Today is day #{@current_program_day}, this was for day #{activity_day_number}."
    else
      "Activity completed on time."
    end
  end

  def completion_response
    {
      success: true,
      activity_id: @program_day_activity.activity_id,
      completed: true,
      current_program_day: @current_program_day,
      activity_day: activity_day_number,
      completed_late: completed_late?,
      message: completion_message
    }
  end
end
