class ProgramDay < ApplicationRecord
  has_many :program_day_activities, dependent: :destroy
  has_many :activities, through: :program_day_activities
end
