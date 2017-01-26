require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = Kernel.rand(101)

get '/web_guesser' do
  color, message = check_guess(params[:guess])
  erb :index, :locals => { :message => message, :color => color }
end

private

def check_guess(guess)
  return 'blue', 'Guess a number between 0 and 100' if guess.nil?
  # params[:rando] is set for tests
  random_number = params[:rando].nil? ? RANDOM_NUMBER : params[:rando].to_i
  build_message(guess.to_i, random_number)
end

def build_message(guess, random_number)
  return 'green', 'You got it right!' if guess.to_i == random_number
  message = []
  message << 'way'       if (guess.to_i - random_number).abs > 10
  message << 'too high!' if guess.to_i > random_number
  message << 'too low!'  if guess.to_i < random_number
  color = determine_color(message)
  return color, message.join(' ').capitalize
end

def determine_color(message)
  return message.include?('way') ? '#ff0000' : '#ff6666'
end
