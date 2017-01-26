require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = Kernel.rand(101)

get '/web_guesser' do
  message = check_guess(params[:guess])
  erb :index, :locals => { :message => message }
end

private

def check_guess(guess)
  return 'Guess a number between 0 and 100' if guess.nil?
  # params[:rando] is set for tests
  random_number = params[:rando].nil? ? RANDOM_NUMBER : params[:rando].to_i
  return 'You got it right!' if guess.to_i == random_number

  message = []
  message << 'way'       if (guess.to_i - random_number).abs > 10
  message << 'too high!' if guess.to_i > random_number
  message << 'too low!'  if guess.to_i < random_number
  message.join(' ').capitalize
end
