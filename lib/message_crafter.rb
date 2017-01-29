class MessageCrafter
  attr_reader :answer

  def initialize(params, session)
    @guess = params[:guess] ? params[:guess].to_i : nil
    @random_number = session[:random_number]
    @answer = params[:cheat] ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{@random_number}" : nil
    @message = nil
    @params = params
    @session = session
  end

  def message
    @message ||= check_guess
  end

  def color
    return 'blue' if message.include?('Guess')
    return 'green' if message.include?('You got it right!')
    return 'blue' if message.include?('Nice try!')
    return message.include?('Way') ? '#ff0000' : '#ff6666'
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
      return 'You got it right! Try again with a new number!'
    elsif @session[:guesses] > 0
      message << 'way'       if (@guess - @random_number).abs > 10
      message << 'too high!' if @guess > @random_number
      message << 'too low!'  if @guess < @random_number
      message = message.join(' ').capitalize
    else
      reset
      message = [
        'Nice try!',
        "The number was #{@random_number}.",
        'Try again with a new number!',
      ].join(' ')
    end
    return message
  end

  def reset
    # params[:rando] is set for tests
    @session[:random_number] = @params[:rando] ? @params[:rando].to_i : Kernel.rand(101)
    @session[:guesses] = 5
  end
end
