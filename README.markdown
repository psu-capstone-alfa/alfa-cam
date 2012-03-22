## Installation

### Local Development

    # Install dependencies
    bundle install

    # Use local sqlite databases by default
    cp config/database.yml.example config/database.yml

    # Build the database and seed basic data
    bundle exec rake db:reset

    # Start a local server
    bundle exec rails s


### Production

#### First-Time Setup

Use the following instructions to start a fresh version of the application.
If you would like to update a currently running installation,
jump ahead to the next section.

    # Install dependencies
    bundle install

    # Copy basic database config for editing
    cp config/database.yml.example config/database.yml
    # Then edit to use database setup of your choice,
    # Use the production environment only

    # Copy basic mail config
    cp config/initializers/setup_mail.rb.example config/initializers/setup_mail.rb
    # Then configure with mail host settings

    # Build and seed database with bootstrapped data
    RAILS_ENV=production bundle exec rake db:create db:seed

    # And then run rails server however you please (rackup, thin, passenger, etc)
    # Example:
    RAILS_ENV=production bundle exec rackup

#### Updating

Be sure to read any update notes and documentation,
as there may be additional configuration required in new versions.

    # To avoid data corruption during update:

    # !!! Disable the application before continuing !!!
    # !!! Make sure you have a database backup before continuing !!!

    # Update the git repository to the desired new version
    # For example: git checkout v2.0

    # Update database with any changes needed for the new version
    RAILS_ENV=production bundle exec rake db:migrate

    # Perform any other updates as specified by update notes

    # Update complete, enable the application again

