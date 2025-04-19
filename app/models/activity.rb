class Activity < ApplicationRecord
  has_many :program_day_activities
  has_many :program_days, through: :program_day_activities
end
