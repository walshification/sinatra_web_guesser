class Correct
  attr_reader :cheat, :message

  def initialize(session, cheat)
    @cheat = cheat ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{session[:random_number]}" : nil
    @session = session
    @message = check_guess
  end

  def color
    'green'
  end

  def guesses
    @session[:guesses]
  end

  private

  def check_guess
    @session[:guesses] = 5

    'You got it right! Try again with a new number!'
  end
end
