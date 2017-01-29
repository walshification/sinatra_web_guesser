require_relative 'messages'

class MessageCrafter
  attr_reader :cheat, :message

  MESSAGES = {
    'way high' => WayHigh,
    'way low' => WayLow,
    'high' => High,
    'low' => Low,
    'correct' => Correct,
  }

  def initialize(params, session)
    @guess = params[:guess] ? params[:guess].to_i : nil
    @random_number = session[:random_number]
    @cheat = params[:cheat] ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{@random_number}" : nil
    @session = session
    @params = params
    @message = check_guess
  end

  def self.for(params, session)
    if params[:guess].to_i == session[:random_number]
      klass = 'correct'
    elsif params[:guess].to_i - session[:random_number] > 10
      klass = 'way high'
    elsif params[:guess].to_i - session[:random_number] < -10
      klass = 'way low'
    elsif params[:guess].to_i > session[:random_number]
      klass = 'high'
    elsif params[:guess].to_i < session[:random_number]
      klass = 'low'
    end
    MESSAGES[klass].new(session, params[:guess].to_i, params[:rando], params[:cheat])
  end

  def color
    return 'blue' if @message.include?('Guess') || message.include?('Nice try!')
    return 'green' if @message.include?('You got it right!')
    return @message.include?('Way') ? '#ff0000' : '#ff6666'
  end

  def guesses
    @session[:guesses]
  end

  private

  def check_guess
    return 'Guess a number between 0 and 100' if @guess.nil?
    @session[:guesses] -= 1
    build_message
  end

  def build_message
    message = []
    if @guess == @random_number
      reset
      @message = 'You got it right! Try again with a new number!'
    elsif @session[:guesses] > 0
      message << 'way'       if (@guess - @random_number).abs > 10
      message << 'too high!' if @guess > @random_number
      message << 'too low!'  if @guess < @random_number
      @message = message.join(' ').capitalize
    else
      reset
      @message = [
        'Nice try!',
        "The number was #{@random_number}.",
        'Try again with a new number!',
      ].join(' ')
    end
  end

  def reset
    # params[:rando] is set for tests
    @session[:random_number] = @params[:rando] ? @params[:rando].to_i : Kernel.rand(101)
    @session[:guesses] = 5
  end
end
