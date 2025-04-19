FactoryBot.define do
  factory :program_day_activity do
    association :activity
    association :program_day
    association :user
    completed { false }
    program_start_date { Date.today - 2 }
    program_end_date   { Date.today + 28 } 
  end
end
