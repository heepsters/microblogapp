#requires all of the gems needed for the poject
require 'sinatra'
require 'sinatra/activerecord'
require 'sendgrid-ruby'
require 'pony'
include SendGrid
enable :sessions
set :database, "sqlite3:blog.sqlite3"
require './models'
# finds the user id of the current user so we can use the current user method
def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end

#########################################################################
#set up the home page to log out anyone logged in and takes them to create account
get '/'  do 
    session[:user_id]= nil
    erb :create_account
end
#creates a new account for the user and sends them an email for conformation
post '/create_account' do 
    @email = params[:email]
    @user = User.create(params)
    html_email = "Click the link to verify your account! http://localhost:4567/verify?user_id=#{@user.id}"
    @pony = Pony.mail(:to => @email, :from => 'Account@developerscloud.com', :subject => 'Verify your account', :body => html_email)
    redirect '/please_verify'
  end
#verify comes from the email and makes it so the account is active and can be used it them
#redirects you to sign in
get '/verify' do 
    puts "HERE IS THE USER ID #{params[:user_id]}"
    @user = User.find params[:user_id]
    @user.verified = true
    @user.save
    redirect '/sign_in'
end
#tells you to check your email
get '/please_verify' do  
  erb :verify
end

######################################################################
#sign in page
get '/sign_in'  do 
    erb :sign_in
end
 #sign in takes your email and finds the user that has it it then matches the emails and logs you in
 #if you log in wrong it makes you sign in again
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
#home shows the feed of posts from all users
get '/home_feed'  do 
    @posts = Post.all
    puts @posts.inspect
    @user = current_user
    erb :home_feed
end

######################################################################
get '/create_post' do 
  erb :create_post
end
#makes a new post and fills it in with the content passed through the form
post '/create_post' do
  @post = current_user.posts.create(content: params[:content]) 
  @post.save
  redirect '/home_feed'
end
#finds the id of the post and allows you to change what is stored
get '/editpost/:post_id' do
    @post = Post.find(params[:post_id])
    erb :editpost
end
#after submitting the for this saves the changes and redirects you home
post '/editpost/:post_id' do 
    @post = Post.find(params[:post_id])
    @post.update_attributes(params[:post])
    redirect '/home_feed'
end
 #this finds the post by id and destroys it
get '/deletepost/:post_id' do
    @post = Post.find(params[:post_id])
    @post.destroy
    redirect '/home_feed'
end
######################################################################
#this gives the details on the current user logged in
get '/user_settings'  do
    @user = current_user
    erb :user_settings
end
#this lets you change what is stored through a form and saves it 
post '/edit' do 
    current_user.update_attributes(params)
    redirect '/user_settings'
end
# This finds the current user and deletes their account
get '/deleteuser' do 
    current_user.destroy
    redirect '/'
end


######################################################################
#This is the profile page and it shows all of the users posts as well as some details about them
get '/user_profile'  do 
    @posts = current_user.posts.order(:id).first(10)
    @user = current_user
    erb :user_profile
end
#this is used to view other users pages based on the user id
get '/user_profile/:user_id' do
    @user = User.find(params[:user_id])
    @posts = @user.posts
    erb :user_profile
end

#####################################################################
#this shows all users that are in the data base
get '/all_users' do
    @user = User.all
    erb :all_users
end








