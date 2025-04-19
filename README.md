# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

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
