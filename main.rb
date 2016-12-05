 require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite3:blog.sqlite3"
require './models'