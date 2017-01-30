class Low
  attr_reader :cheat, :message, :session

  def initialize(session, cheat)
    @random_number = session[:random_number]
    @cheat = cheat ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{@random_number}" : nil
    @session = session
    check_guess
  end

  def color
    '#ff6666'
  end

  def guesses
    @session[:guesses]
  end

  private

  def check_guess
    @session[:guesses] -= 1
    build_message
  end

  def build_message
    if @session[:guesses] > 0
      @message = 'Too low!'
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
    @session[:random_number] = Kernel.rand(101)
    @session[:guesses] = 5
  end
end
