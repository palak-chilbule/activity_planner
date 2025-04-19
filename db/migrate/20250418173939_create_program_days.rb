class CreateProgramDays < ActiveRecord::Migration[7.1]
  def change
    create_table :program_days do |t|
      t.integer :day_number

      t.timestamps
    end
  end
end
