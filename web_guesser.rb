require 'sinatra'
require 'sinatra/reloader'

enable :sessions

get '/web_guesser' do
  if session[:random_number].nil?
    reset
  end
  color, message = check_guess(params[:guess])
  erb :index, :locals => {
    message: message,
    color: color,
    count: session[:guesses],
  }
end

get '/reset' do
  reset
end

private

def check_guess(guess)
  return 'blue', 'Guess a number between 0 and 100' if guess.nil?
  # params[:rando] is set for tests
  random_number = params[:rando].nil? ? session[:random_number] : params[:rando].to_i
  session[:guesses] -= 1
  build_message(guess.to_i, random_number)
end

def build_message(guess, random_number)
  if guess.to_i == random_number
    reset
    return 'green', 'You got it right! Try again with a new number!'
  end
  message = []
  if session[:guesses] > 0
    message << 'way'       if (guess.to_i - random_number).abs > 10
    message << 'too high!' if guess.to_i > random_number
    message << 'too low!'  if guess.to_i < random_number
  else
    reset
    message << "Nice try! The number was #{random_number}. Try again with a new number!"
  end
  color = determine_color(message)
  return color, message.join(' ').capitalize
end

def determine_color(message)
  return 'blue' if session[:guesses] == 0
  return message.include?('way') ? '#ff0000' : '#ff6666'
end

def reset
  session[:random_number] = Kernel.rand(101)
  session[:guesses] = 5
end
