require 'sinatra/base'

class database < Sinatra::Base
  get '/' do
    'Hello database!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
