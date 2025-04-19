require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe SendReminderEmailWorker, type: :worker do
  let!(:user) { create(:user) }
  let!(:activity1) { create(:activity, title: 'Yoga') }
  let!(:activity2) { create(:activity, title: 'Running') }
  
  let!(:program_day1) { create(:program_day, day_number: 1) }
  let!(:program_day2) { create(:program_day, day_number: 2) }

  let!(:program_day_activity1) { 
    create(:program_day_activity, user: user, activity: activity1, program_day: program_day1, completed: false, program_start_date: Date.today - 1)
  }
  let!(:program_day_activity2) { 
    create(:program_day_activity, user: user, activity: activity2, program_day: program_day2, completed: false, program_start_date: Date.today - 1)
  }

  before do
    Sidekiq::Testing.inline!
  end

  describe '#perform' do

    it 'sends the correct number of reminder emails' do
      program_day_activity1.update(completed: true)

      expect { SendReminderEmailWorker.new.perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe 'ReminderHelper' do
    it 'groups pending activities by user' do
      reminders = ReminderHelper.pending_activities_for_today

      expect(reminders[user]).to match_array([program_day_activity1, program_day_activity2])
    end
  end
end
