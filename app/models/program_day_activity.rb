class ProgramDayActivity < ApplicationRecord
  belongs_to :program_day 
  belongs_to :activity
  belongs_to :user
end
