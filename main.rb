require 'sinatra'
require 'sinatra/activerecord'
require 'sendgrid-ruby'
include SendGrid

set :database, "sqlite3:blog.sqlite3"
require './models'

get '/'  do 
	erb :homepage
end

get '/create_account'  do 
	erb :create_account
end

post '/create_account' do 
	puts params.inspect
	@email = params[:email]

data = JSON.parse('{
  "personalizations": [
    {
      "to": [
        {
          "email": "'+ @email +'"
        }
      ],
      "subject": "Verify your account"
    }
  ],
  "from": {
    "email":  "account@heepsters.com" 
  },
  "content": [
    {
      "type": "text/plain",
      "value": "lets see if this goes through"
    }
  ]
}')
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._("send").post(request_body: data)
puts response.status_code
puts response.body
puts response.headers
	erb :user_settings
end

get '/user_settings'  do 
	erb :user_settings
end

post '/user_settings' do  

end

get '/sign_in'  do 
	erb :sign_in
end

get '/home_feed'  do 
	erb :home_feed
end

get '/user_profile'  do 
	erb :user_profile
end

