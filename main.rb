require 'sinatra'
require 'sinatra/activerecord'
require 'sendgrid-ruby'
require 'pony'
include SendGrid
enable :sessions
set :database, "sqlite3:blog.sqlite3"
require './models'

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end

#########################################################################
get '/'  do 
    session[:user_id]= nil
    erb :create_account
end

post '/create_account' do 
    @email = params[:email]
    @user = User.create(params)
    html_email = "Click the link to verify your account! http://localhost:4567/verify?user_id=#{@user.id}"
    @pony = Pony.mail(:to => @email, :from => 'Account@developerscloud.com', :subject => 'Verify your account', :body => html_email)
    redirect '/please_verify'
  end

get '/verify' do 
    puts "HERE IS THE USER ID #{params[:user_id]}"
    @user = User.find params[:user_id]
    @user.verified = true
    @user.save
    redirect '/sign_in'
end

get '/please_verify' do  
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
	        redirect '/home_feed'    
	    else     
	        redirect '/sign_in'   
	 end 
end  
######################################################################
get '/home_feed'  do 
    @posts = Post.all
    erb :home_feed
end

######################################################################
get '/create_post' do 
  erb :create_post
end

post '/create_post' do
  @post = current_user.posts.create(content: params[:content]) 
  @post.save
  redirect '/home_feed'
end

get '/editpost/:post_id' do
    @post = Post.find(params[:post_id])
    erb :editpost
end

post '/editpost/:post_id' do 
    @post = Post.find(params[:post_id])
    puts params.inspect
    @post.update_attributes(params[:post])
    redirect '/home_feed'
end

get '/deletepost/:post_id' do
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect '/home_feed'
end
######################################################################
get '/user_settings'  do
    @user = current_user
    erb :user_settings
end

post '/edit' do 
    current_user.update_attributes(params)
    redirect '/user_settings'
end

get '/deleteuser' do 
    current_user.destroy
    redirect '/'
end


######################################################################
get '/user_profile'  do 
    @posts = current_user.posts
    @user = current_user
    erb :user_profile
end

get '/user_profile/:user_id' do
    @user = User.find(params[:user_id])
    @posts = @user.posts
    erb :user_profile
end

#####################################################################
get '/all_users' do
    @user = User.all
    erb :all_users
end








