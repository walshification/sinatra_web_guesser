class High
  attr_reader :cheat, :color, :message, :session

  def initialize(session, cheat)
    @random_number = session[:random_number]
    @cheat = cheat ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{@random_number}" : nil
    @session = session
    @color = '#ff6666'
    check_guess
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
      @message = 'Too high!'
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
    @session[:random_number] = Kernel.rand(101)
    @session[:guesses] = 5
  end
end
