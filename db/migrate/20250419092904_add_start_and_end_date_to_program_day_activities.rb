class AddStartAndEndDateToProgramDayActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :program_day_activities, :program_start_date, :datetime
    add_column :program_day_activities, :program_end_date, :datetime
  end
end
