# app/helpers/reminder_helper.rb
module ReminderHelper
  def self.pending_activities_for_today
    reminders = {}
    today = Date.today

    ProgramDayActivity.includes(:activity, :program_day, :user).find_each do |program_day_activity|
      program_start_date = program_day_activity.program_start_date.to_date

      current_day_number = (today - program_start_date).to_i + 1
      next if current_day_number < 1  

      next if program_day_activity.completed || program_day_activity.program_day.day_number > current_day_number

      reminders[program_day_activity.user] ||= []
      reminders[program_day_activity.user] << program_day_activity
    end

    reminders
  end
end
