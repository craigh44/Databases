require "data_mapper"
require 'sinatra'
require 'rack-flash'
require './lib/helpers/helpers.rb'

require './lib/link' # this needs to be done after datamapper is initialised
require './lib/tag'
require './lib/user'
require './lib/controllers/users.rb'
require './lib/controllers/tags.rb'
require './lib/controllers/links.rb'

require_relative 'data_mapper_setup'
enable :sessions
set :session_secret, 'super secret'
use Rack::Flash 
set :views, Proc.new { File.join(root, "..", "views") }

get '/' do
  @links = Link.all
  erb :index
end




