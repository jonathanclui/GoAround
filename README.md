# GoAround
GoAround is web application that allows you to compare your transportation options and request Ubers from desktop.

##Configuration
You need your own Uber Developer API CLIENT_ID key and CLIENT_SECRET key in order to run. Run the command below and edit the application.yml file to contain your keys.
* cp config/application.example.yml config/application.yml
You will need to specify the mailer (I used SENDGRID). If you would like to keep the same settings that are in config/production.rb make sure you set your ENV['SENDGRID_USERNAME'] and ENV['SENDGRID_PASSWORD'] variables on your production server.

If you do not wish to send mail simply specify any server in your config/application.yml for the MAILER_HOST (ex. use localhost: 3000).

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
