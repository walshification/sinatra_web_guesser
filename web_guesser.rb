require 'sinatra'
require 'sinatra/reloader'
require './lib/message_crafter'

enable :sessions

get '/web_guesser' do
  message = MessageCrafter.for(params, session)
  session.update(message.session)
  erb :index, :locals => { message: message }
end
