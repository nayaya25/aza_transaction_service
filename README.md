# README

This README contains the steps are necessary to get the
application up and running.

* The endpoints are namespaced under 'api/v1' for easier versioning

#### Ruby version
  - 2.7.4
#### Rails version
- 6.0.4
#### Configuration
  - Ensure you have docker and docker-compose set up
  - Run: docker-compose up
#### Database creation
  - Run: docker-compose run web rake db:create
#### Database initialization
  - Run: docker-compose run web rake db:migrate
  - Run: docker-compose run web rake db:migrate RAILS_ENV=test
#### How to run the test suite
  - Run: docker-compose run web rspec

