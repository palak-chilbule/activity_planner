# README
Tech Stack
- Ruby on Rails
- PostgreSQL
- Sidekiq (background jobs)
- Redis
- Docker / Docker Compose

* If running using docker
Prerequisites:
- Docker
- Docker Compose

run following commands:
    git clone https://github.com/palak-chilbule/activity_planner.git
    cd activity_planner
    docker-compose build
    docker-compose run web rails db:create db:migrate db:seed
    docker-compose up

* Else

* Ruby version
3.2.2

* Rails version
7.1.5.1

* Bundler version
2.6.8

* Installation steps with Rbenv in dev environment:
1. Install Rbenv : brew install rbenv
2. rbenv init
3. rbenv install 3.3.0
4. rbenv local 3.3.0
5. rbenv versions - Check ruby version installed.
6. gem install bundler -v "2.6.8" - If bundler not installed.
7. bundle install
8. rake db:migrate
9. rake db:seed

* System dependencies

* Configuration

* Database setup
run following commands one after other in your project directoery
    rails db:setup

    rake db:create
    rake db:migrate
    rake db:seed

    rails db:setup

* Test suite
run command
    bundle exec rspec

* To start rails development server
    rails server
note: the server will start runnig on localhost:3000

* Workers 
    To start Redis server
        brew services start redis
    To start sidekiq
        bundle exec sidekiq
note: for sidekiq to start redis server needs to runnig

* API URLS :
   URL: GET /api/v1/program_days/:day_number/activities
        Controller#Action: Api::V1::ProgramDaysController#activities
        Purpose: Fetches all activities for a specific program
        Required params: user_id
        example: GET /api/v1/program_days/3/activities?user_id=1

   URL: PATCH /api/v1/program_day_activities/:id/complete
        Controller#Action: Api::V1::ProgramDayActivitiesController#complete
        Purpose: Marks a ProgramDayActivity as completed
        example: PATCH /api/v1/program_day_activities/5/complete

   URL: GET /api/v1/activities
       Controller#Action: Api::V1::ActivitiesController#index
       Purpose: List all activities

   URL: POST /api/v1/activities
        Controller#Action: Api::V1::ActivitiesController#create
        Purpose: Create a new activity

   URL: PATCH/PUT /api/v1/activities/:id
        Controller#Action: Api::V1::ActivitiesController#update
        Purpose: Update an existing activity

   URL: DELETE /api/v1/activities/:id
        Controller#Action: Api::V1::ActivitiesController#destroy
        Purpose: Delete an activity

   URL: GET /api/v1/program_days
        Controller#Action: Api::V1::ProgramDaysController#index
        Purpose: List all program days

* Controller Overview
This project provides a basic Activity Planning API for managing user-specific daily activities within a 30-day program. The logic is split across three main controllers:

1. Api::V1::ActivitiesController
Handles CRUD operations for Activities.

2. Api::V1::ProgramDaysController
Manages Program Day records and user-specific activity fetching based on day number.

Returns total activities for the day, remaining (incomplete) ones, and each activity’s status.

Requires a valid user_id query param.

If the user or day is not found, returns a 404 with error message.

3. Api::V1::ProgramDayActivitiesController
Allows a user to mark an activity as completed based on the current day in their program

Key Features:
Calculates the current program day using program_start_date on the activity.

Prevents users from completing future activities (compares with day_number).

Returns detailed response including:

Whether the activity was completed late or on time

Current program day

Activity's assigned day

Success status and message

* Models/Associations Summary

User has many ProgramDayActivities

ProgramDayActivity belongs to:
    A User
    An Activity
    A ProgramDay

ProgramDay defines the day number (e.g., day 1 to day 30)

Each ProgramDayActivity includes:
    program_start_date
    program_end_date    
    completed status

 * Background Job: SendReminderEmailWorker
    This worker is responsible for sending daily reminder emails to users about their pending activities for the current day of their 30-day program.

    What it does:
        Fetches all ProgramDayActivity records that:
            Belong to a user
            Have not been marked as completed
            Are scheduled for today or earlier (future activities are ignored)
        Groups these pending activities by user
        Sends one consolidated reminder email per user listing their pending activities

        Uses:
            ReminderHelper.pending_activities_for_today:
                Custom helper that filters and returns a hash of user => [pending_activities]
                Uses program_start_date and day_number to calculate which activities are due
            UserMailer.reminder_email(user, activities):
                Sends the actual email via ActionMailer
                Expected to render a list of pending activity titles and details 

    added this job to be performed in sidekiq.yml which triggers everyday at 8PM

        

