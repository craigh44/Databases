require 'sinatra/base'

class database < Sinatra::Base

set :views, Proc.new { File.join(root, "..", "views") }

 get '/' do
  @links = Link.all
  erb :index
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
