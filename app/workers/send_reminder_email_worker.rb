class SendReminderEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'mailers'

  def perform
    reminders = ReminderHelper.pending_activities_for_today

    reminders.each do |user, activities|
      UserMailer.reminder_email(user, activities).deliver_now
    end
  end
end