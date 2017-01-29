require 'sinatra'
require 'sinatra/reloader'
require './lib/message_crafter'

enable :sessions

get '/web_guesser' do
  reset if session[:random_number].nil?

  if chosen?
    message_crafter = MessageCrafter.for(params, session)
  else
    message_crafter = MessageCrafter.new(params, session)
  end

  erb :index, :locals => { message_crafter: message_crafter }
end

get '/reset' do
  reset
  redirect to('/web_guesser')
end

private

def reset
  # params[:rando] is set for tests
  session[:random_number] = params[:rando] ? params[:rando].to_i : Kernel.rand(101)
  session[:guesses] = 5
end

def chosen?
  (params[:guess].to_i == session[:random_number] ||
   params[:guess].to_i - session[:random_number] > 10)
end
