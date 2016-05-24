require 'sinatra'
require 'sinatra/activerecord'
require './models/model'        #Model class

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database:  'db/development.sqlite3'
)

get '/' do
	erb :index
end

post '/submit' do
	@model = Model.new(params[:model])
	if @model.save
		redirect '/models'
	else
		"Sorry, there was an error!"
	end
end

get '/models' do
	@models = Model.all
	erb :models
end

after do
  # Close the connection after the request is done so that we don't
  # deplete the ActiveRecord connection pool.
  ActiveRecord::Base.connection.close
end
