class CreateProgramDayActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :program_day_activities do |t|
      t.references :program_day, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :completed, default: false 

      t.timestamps
    end
  end
end
