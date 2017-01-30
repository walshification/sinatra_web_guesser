class WayLow
  attr_reader :cheat, :message, :session

  def initialize(session, cheat)
    @cheat = cheat ? "CHEAT MODE ACTIVATED! THE ANSWER IS #{session[:random_number]}" : nil
    @session = session
    check_guess
  end

  def color
    '#ff0000'
  end

  def guesses
    @session[:guesses]
  end

  private

  def check_guess
    if @session[:guesses] == 1
      old_number = @session[:random_number]
      @session[:random_number] = Kernel.rand(101)
      @session[:guesses] = 5
      @message = "Nice try! The number was #{old_number}. Try again with a new number"
    else
      @session[:guesses] -= 1
      @message = 'Way too low!'
    end
  end
end
