class WayHigh
  attr_reader :cheat, :message

  def initialize(session, guess, rando, cheat)
    @guess = guess
    @rando = rando ? rando.to_i : nil  # set in tests
    @random_number = session[:random_number]
    @cheat = cheat ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{@random_number}" : nil
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
