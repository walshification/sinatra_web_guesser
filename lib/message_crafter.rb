require_relative 'messages'

class MessageCrafter
  attr_reader :cheat, :message

  MESSAGES = {
    'new'      => NewMessage,
    'way high' => WayHigh,
    'way low'  => WayLow,
    'high'     => High,
    'low'      => Low,
    'correct'  => Correct,
  }

  def self.for(params, session)
    if session[:random_number].nil?
      klass = 'new'
    elsif params[:guess].to_i == session[:random_number]
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
    MESSAGES[klass].new(session, params[:cheat])
  end
end
