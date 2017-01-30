require 'sinatra'
require 'sinatra/reloader'
require './lib/message_crafter'

enable :sessions

get '/web_guesser' do
  message_crafter = MessageCrafter.for(params, session)
  session.update(message_crafter.session)
  erb :index, :locals => { message_crafter: message_crafter }
end

get '/reset' do
  reset
  redirect to('/web_guesser')
end

private

def reset
  session[:random_number] = nil
  session[:guesses] = 5
end
