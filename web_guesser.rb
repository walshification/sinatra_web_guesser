require 'sinatra'
require 'sinatra/reloader'

RANDOM_NUMBER = Kernel.rand(101)

get '/web_guesser' do
  random_number = params[:rando].to_i || RANDOM_NUMBER
  unless params[:guess]
    message = 'Guess a number between 0 and 100!'
  end
  if params[:guess]
    if params[:guess].to_i > random_number
      message = 'Too high!'
    elsif params[:guess].to_i < random_number
      message = 'Too low!'
    else
      message = "You got it right!"
    end
  end
  erb :index, :locals => { :message => message }
end
