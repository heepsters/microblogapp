require 'sinatra'
require 'sinatra/activerecord'
require 'sendgrid-ruby'
include SendGrid
enable :sessions
set :database, "sqlite3:blog.sqlite3"
require './models'
#########################################################################
get '/'  do 
    erb :create_account
end


def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end

post '/create_account' do 
	puts params.inspect
	@email = params[:email]
	@user = User.create(params)
	html_email = "Click the link to verify your account! http://localhost:4567/verify?user_id=#{@user.id}"
# 	html_email = <<HTML
# 	#<html>\r\n<head>\r\n<title>Email test<\/title>\r\n<\/head>\r\n<body>\r\n<h1 style=\"text-align: center;\"><span class=\"sg-image\" data-imagelibrary=\"%7B%22width%22%3A%2299%22%2C%22height%22%3A%2267%22%2C%22alt_text%22%3A%22developerscloud.com%22%2C%22alignment%22%3A%22center%22%2C%22border%22%3A0%2C%22src%22%3A%22https%3A\/\/marketing-image-production.s3.amazonaws.com\/uploads\/8a6e90e3748b6efc4a2e23863e585f9b649c5085705ba4e0e8017ce2fb891a2eb1e87aa4ef108b09bf38c09581e0a115d585c3f60e0cab4e834230bf0f4e94e4.jpg%22%2C%22link%22%3A%22%22%2C%22classes%22%3A%7B%22sg-image%22%3A1%7D%7D\" style=\"display: block; float: none; text-align: center;\"><img alt=\"developerscloud.com\" height=\"67\" src=\"https:\/\/marketing-image-production.s3.amazonaws.com\/uploads\/8a6e90e3748b6efc4a2e23863e585f9b649c5085705ba4e0e8017ce2fb891a2eb1e87aa4ef108b09bf38c09581e0a115d585c3f60e0cab4e834230bf0f4e94e4.jpg\" style=\"width: 99px; height: 67px;\" width=\"99\" \/><\/span><span style=\"font-family:lucida sans unicode,lucida grande,sans-serif;\">Hi fname!<\/span><\/h1>\r\n\r\n<h2 style=\"text-align: center;\"><span style=\"font-family:lucida sans unicode,lucida grande,sans-serif;\">Thank you for signing up with<\/span><\/h2>\r\n\r\n<h2 style=\"text-align: center;\"><span style=\"font-family:lucida sans unicode,lucida grande,sans-serif;\">developerscloud.com!<\/span><\/h2>\r\n\r\n<p style=\"text-align: center;\"><font face=\"lucida sans unicode, lucida grande, sans-serif\">Please click the link below to verify that you have successfully created an account with us.<\/font><\/p>\r\n\r\n<p style=\"text-align: center;\">&nbsp;<\/p>\r\n\r\n<div style=\"text-align: center;\"><span class=\"sg-image\" data-imagelibrary=\"%7B%22width%22%3A%22262%22%2C%22height%22%3A%2240%22%2C%22alignment%22%3A%22center%22%2C%22src%22%3A%22https%3A\/\/marketing-image-production.s3.amazonaws.com\/uploads\/2722daad790e9a3f151bec49651de63f6b17828f1d5ced4e5654c0414cc29e7b5e167c5247686527fbfbf081312d0f5ede5638e2b0a9328b0cf2a8a7edda4402.jpg%22%2C%22alt_text%22%3A%22%22%2C%22link%22%3A%22%22%2C%22classes%22%3A%7B%22sg-image%22%3A1%7D%7D\" style=\"float: none; display: block; text-align: center;\"><img height=\"40\" src=\"https:\/\/marketing-image-production.s3.amazonaws.com\/uploads\/2722daad790e9a3f151bec49651de63f6b17828f1d5ced4e5654c0414cc29e7b5e167c5247686527fbfbf081312d0f5ede5638e2b0a9328b0cf2a8a7edda4402.jpg\" style=\"width: 262px; height: 40px;\" width=\"262\" \/><\/span><\/div>\r\n\r\n<div style=\"text-align: center;\">&nbsp;<\/div>\r\n\r\n<div style=\"text-align: center;\">&lt;%body%&gt;<\/div>\r\n<\/body>\r\n<\/html>
end


post '/create_account' do 
    puts params.inspect
    @email = params[:email]
    @user = User.create(params)
    html_email = "Click the link to verify your account! http://localhost:4567/verify?user_id=#{@user.id}"
#   html_email = <<HTML
#   #<html>\r\n<head>\r\n<title>Email test<\/title>\r\n<\/head>\r\n<body>\r\n<h1 style=\"text-align: center;\"><span class=\"sg-image\" data-imagelibrary=\"%7B%22width%22%3A%2299%22%2C%22height%22%3A%2267%22%2C%22alt_text%22%3A%22developerscloud.com%22%2C%22alignment%22%3A%22center%22%2C%22border%22%3A0%2C%22src%22%3A%22https%3A\/\/marketing-image-production.s3.amazonaws.com\/uploads\/8a6e90e3748b6efc4a2e23863e585f9b649c5085705ba4e0e8017ce2fb891a2eb1e87aa4ef108b09bf38c09581e0a115d585c3f60e0cab4e834230bf0f4e94e4.jpg%22%2C%22link%22%3A%22%22%2C%22classes%22%3A%7B%22sg-image%22%3A1%7D%7D\" style=\"display: block; float: none; text-align: center;\"><img alt=\"developerscloud.com\" height=\"67\" src=\"https:\/\/marketing-image-production.s3.amazonaws.com\/uploads\/8a6e90e3748b6efc4a2e23863e585f9b649c5085705ba4e0e8017ce2fb891a2eb1e87aa4ef108b09bf38c09581e0a115d585c3f60e0cab4e834230bf0f4e94e4.jpg\" style=\"width: 99px; height: 67px;\" width=\"99\" \/><\/span><span style=\"font-family:lucida sans unicode,lucida grande,sans-serif;\">Hi fname!<\/span><\/h1>\r\n\r\n<h2 style=\"text-align: center;\"><span style=\"font-family:lucida sans unicode,lucida grande,sans-serif;\">Thank you for signing up with<\/span><\/h2>\r\n\r\n<h2 style=\"text-align: center;\"><span style=\"font-family:lucida sans unicode,lucida grande,sans-serif;\">developerscloud.com!<\/span><\/h2>\r\n\r\n<p style=\"text-align: center;\"><font face=\"lucida sans unicode, lucida grande, sans-serif\">Please click the link below to verify that you have successfully created an account with us.<\/font><\/p>\r\n\r\n<p style=\"text-align: center;\">&nbsp;<\/p>\r\n\r\n<div style=\"text-align: center;\"><span class=\"sg-image\" data-imagelibrary=\"%7B%22width%22%3A%22262%22%2C%22height%22%3A%2240%22%2C%22alignment%22%3A%22center%22%2C%22src%22%3A%22https%3A\/\/marketing-image-production.s3.amazonaws.com\/uploads\/2722daad790e9a3f151bec49651de63f6b17828f1d5ced4e5654c0414cc29e7b5e167c5247686527fbfbf081312d0f5ede5638e2b0a9328b0cf2a8a7edda4402.jpg%22%2C%22alt_text%22%3A%22%22%2C%22link%22%3A%22%22%2C%22classes%22%3A%7B%22sg-image%22%3A1%7D%7D\" style=\"float: none; display: block; text-align: center;\"><img height=\"40\" src=\"https:\/\/marketing-image-production.s3.amazonaws.com\/uploads\/2722daad790e9a3f151bec49651de63f6b17828f1d5ced4e5654c0414cc29e7b5e167c5247686527fbfbf081312d0f5ede5638e2b0a9328b0cf2a8a7edda4402.jpg\" style=\"width: 262px; height: 40px;\" width=\"262\" \/><\/span><\/div>\r\n\r\n<div style=\"text-align: center;\">&nbsp;<\/div>\r\n\r\n<div style=\"text-align: center;\">&lt;%body%&gt;<\/div>\r\n<\/body>\r\n<\/html>

# HTML
jsonstring = <<STRING
    {
      "personalizations": [
        {
          "to": [
            {
              "email": "#{@email}"
            }
          ],
          "subject": "Verify your account"
        }
      ],
      "from": {
        "email":  "account@developerscloud.com" 
      },
      "content": [
        {
          "type": "text/plain",
          "value": "#{html_email}"
        }
      ]
    }
STRING
data = JSON.parse(jsonstring)
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._("send").post(request_body: data)
puts response.status_code
puts response.body
puts response.headers
    erb :user_settings
end
get '/veryify/:user_id' do 
    puts "HERE IS THE USER ID #{params[:user_id]}"
    @user = User.find params[:user_id]
    @user.verified = true
    @user.save
    redirect '/home_feed'
end
######################################################################
get '/sign_in'  do 
    erb :sign_in
end
 
post '/sign_in' do   
    @user = User.where(email: params[:email]).first   
    if @user && @user.password == params[:password]   
    session[:user_id] = @user.id  
        erb :home_feed      
    else     
        erb :sign_in   
    end 
end     
######################################################################
get '/user_settings'  do 
    erb :user_settings
end
post '/user_settings' do  
end
get '/home_feed'  do 
    erb :home_feed
end
get '/user_profile'  do 
    erb :user_profile
end