require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = rand(101)

get '/web_guesser' do
  "The SECRET NUMBER is #{RANDOM_NUMBER}."
end
