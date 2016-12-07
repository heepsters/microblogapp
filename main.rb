require 'sinatra'
require 'sinatra/activerecord'
require 'sendgrid-ruby'
require 'pony'
include SendGrid
enable :sessions
set :database, "sqlite3:blog.sqlite3"
require './models'
#########################################################################
get '/'  do 
    session[:user_id]= nil
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
    Pony.mail(:to => @email, :html_body => 'Account verification', :body => html_email )
    # Pony.mail(:to => @email, :from => 'Account@developerscloud.com', :subject => 'Verify your account', :body => html_email)

  end

# jsonstring = <<STRING
#     '{
#       "personalizations": [
#         {
#           "to": [
#             {
#               "email": "#{@email}"
#             }
#           ],
#           "subject": "Verify your account"
#         }
#       ],
#       "from": {
#         "email":  "account@developerscloud.com" 
#       },
#       "content": [
#         {
#           "type": "text/plain",
#           "value": "#{html_email}"
#         }
#       ]
#     }'
# STRING
# data = JSON.parse(jsonstring)
# sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
# response = sg.client.mail._("send").post(request_body: data)
# puts response.status_code
# puts response.body
# puts response.headers
# end

get '/verify' do 
    puts "HERE IS THE USER ID #{params[:user_id]}"
    @user = User.find params[:user_id]
    @user.verified = true
    @user.save
    redirect '/user_settings'
end

post '/please_verify' do  
  erb :verify
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
	        redirect '/sign_in'   
	 end 
end  
######################################################################
get '/home_feed'  do 
    @posts = Post.all
    erb :home_feed
end

post '/home_feed' do


end

post '/save_post' do 
  @post = Post.create(content: params[:content], user_id: current_user.id)
  @user = User.fname
  
end

######################################################################
get '/user_settings'  do
    @user = current_user
    
    erb :user_settings
end

post '/user_settings' do  
    current_user.update_attributes(params)
    redirect '/user_profile'
end

######################################################################
get '/user_profile'  do 
    erb :user_profile
end



















