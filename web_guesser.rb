require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = rand(101)

get '/web_guesser' do
  erb :index, :locals => { :number => RANDOM_NUMBER }
end
