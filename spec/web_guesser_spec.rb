RSpec.describe "My Sinatra Application" do
  describe '/web_guesser' do
    it "allows accessing the web_guesser page" do
      get '/web_guesser'
      expect(last_response).to be_ok
    end

    it 'prompts the user for a guess' do
      get '/web_guesser'
      expect(/.*Guess a number between 0 and 100!.*/.match(last_response.body)).to be_truthy
    end

    it 'tells the user a guess is too high' do
      get '/web_guesser?rando=42&guess=50'
      expect(/.*Too high!.*/.match(last_response.body)).to be_truthy
    end

    it 'tells the user a guess is too low' do
      get '/web_guesser?rando=42&guess=30'
      expect(/.*Too low!.*/.match(last_response.body)).to be_truthy
    end

    it 'tells the user a guess is correct' do
      get 'web_guesser?rando=42&guess=42'
      expect(/.*You got it right!.*/.match(last_response.body)).to be_truthy
    end
  end
end
