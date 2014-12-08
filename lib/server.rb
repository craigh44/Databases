require "data_mapper"
require 'sinatra'
require 'rack-flash'



env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, DATABASE_URL)

require './lib/link' # this needs to be done after datamapper is initialised
require './lib/tag'
require './lib/user'
# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash 

set :views, Proc.new { File.join(root, "..", "views") }

 get '/' do
  @links = Link.all
  erb :index
end

post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map{|tag| 
  	Tag.first_or_create(:text => tag)}
  Link.create(:url => url, :title => title, :tags => tags)
  redirect to('/')
end

get '/tags/:text' do
  tag = Tag.first(:text => params[:text])
  @links = tag ? tag.links : []
  erb :index
end

get '/users/new' do
  # note the view is in views/users/new.erb
  # we need the quotes because otherwise
  # ruby would divide the symbol :users by the
  # variable new (which makes no sense)
  @user = User.new
  erb :"users/new"
end

post '/users' do
  # we just initialize the object
  # without saving it. It may be invalid
  @user = User.new(:email => params[:email],
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
  # let's try saving it
  # if the model is valid,
  # it will be saved
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
    # if it's not valid,
    # we'll show the same
    # form again
  else
    flash[:notice] = "Sorry, your passwords don't match"
    erb :"users/new"
  end
end

get '/users/sign_in' do
  erb :"users/sign_in"
end

post '/user/sign_in' do
  email, password = params[:email], params[:password]
  @user = User.authenticate(email, password)
  if @user
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash[:notice] = "The email or password is incorrect"
    erb :"users/sign_in"
  end
end

delete '/sessions' do
  flash[:notice] = "Good bye!"
  session[:user_id] = nil
  redirect to('/')
end



helpers do

  def current_user
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

end


