class SendReminderJob < ApplicationJob
  queue_as :default

  def perform
    ProgramDayActivity.includes(:activity, :user).where(completed: false).find_each do |program_day_activity|
      UserMailer.reminder_email(program_day_activity.user, program_day_activity.activity).deliver_later
    end
  end
end
