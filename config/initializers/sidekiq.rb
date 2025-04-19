require 'sidekiq-scheduler' 

Sidekiq.schedule = {
  'send_reminder_job' => {
    'cron' => '0 20 * * *',
    'class' => 'SendReminderEmailWorker',
    'queue' => 'default'
  }
}

Sidekiq::Scheduler.reload_schedule!

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://localhost:6379/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379/0" }
end