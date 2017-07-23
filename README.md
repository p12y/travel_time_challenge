# Travel Time Challenge

This is a solution to the travel time challenge.

## How to use

Clone the repository, run `bundle install` and `rake db:setup`. Start the development server with `rails s`.

Start by adding a journey. Input start information and add any number of meetings. You can set the duration of the meeting in the form. You will be redirected to a page that lists each meeting and the expected arrival time, taking into account the departure date/time and the duration of each meeting.

## Tests

To prepare the database run `rake db:migrate RAILS_ENV=test`
Then, `rspec` 