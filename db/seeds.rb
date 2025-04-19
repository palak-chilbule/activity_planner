# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by!(name: "Alice", email: "alice@example.com")
program_start_date = Date.today - 13
program_end_date   = Date.today + 16
(14..21).each do |day_num|
 day = ProgramDay.create!(day_number: day_num)
 %w[
   Stimulus\ Explosion:2x/Week
   Advanced\ mobility:Maximize
   Auditory\ Memory\ 2:1x/Day
   Auditory\ Magic:2\ sounds/Day
   Knowledge\ Boosters:2x/Day
   Talk\ To\ Listen:1x/Day
   Energy\ Ball:Maximize
   Visual\ Solfege:1x/Day
 ].each do |entry|
   name, freq = entry.split(":")
   activity = Activity.find_or_create_by!(title: name.strip, frequency: freq.strip, )
   ProgramDayActivity.find_or_create_by!(program_day: day, activity: activity, user: user, program_start_date: program_start_date, program_end_date: program_end_date)
 end
end
