class WayHigh
  attr_reader :cheat, :message, :session

  def initialize(session, cheat)
    @cheat = cheat ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{session[:random_number]}" : nil
    @session = session
    @message = check_guess
  end

  def color
    '#ff0000'
  end

  def guesses
    @session[:guesses]
  end

  private

  def check_guess
    @session[:guesses] -= 1
    'Way too high!'
  end
end
