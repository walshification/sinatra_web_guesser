class NewMessage
  attr_reader :cheat, :color, :message, :session
  def initialize(session, cheat)
    @session = session
    @cheat = cheat ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{session[:random_number]}" : nil
    @message = 'Guess a number between 0 and 100!'
    @session[:guesses] = 5
    @session[:random_number] = Kernel.rand(101)
    @color = 'blue'
  end

  def guesses
    @session[:guesses]
  end
end
