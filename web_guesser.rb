require 'sinatra'
require 'sinatra/reloader'
require './lib/message_crafter'

enable :sessions

get '/web_guesser' do
  reset if session[:random_number].nil?

  message_crafter = MessageCrafter.new(params, session)

  erb :index, :locals => {
    message: message_crafter.message,
    color: message_crafter.color,
    count: message_crafter.guesses,
    answer: message_crafter.answer,
  }
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
