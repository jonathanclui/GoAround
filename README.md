# GoAround
GoAround is web application that allows you to compare your transportation options and request Uber's from desktop.

##Configuration
You need your own Uber Developer API CLIENT_ID key and CLIENT_SECRET key in order to run. Run the command below and edit the application.yml file to contain your keys.
* cp config/application.example.yml config/application.yml

##Database initialization
Run the following command
* rake db:migrate

##Deployment instructions
To deploy to heroku run:
* bundle install
* heroku login
* heroku keys:add
* heroku create
* git push heroku master

This assumes you have a Heroku account created