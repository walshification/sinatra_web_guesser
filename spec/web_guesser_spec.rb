RSpec.describe "My Sinatra Application" do
  describe '/web_guesser' do
    it "allows accessing the web_guesser page" do
      get '/web_guesser'
      expect(last_response).to be_ok
    end

    it 'prompts the user for a guess' do
      get '/web_guesser'
      expect(last_response.body).to include('Guess a number between 0 and 100')
    end

    it 'tells the user a guess is correct' do
      get 'web_guesser?rando=42&guess=42'
      expect(last_response.body).to include('You got it right!')
    end

    context 'off by more than ten' do
      it 'tells the user a guess is way too high' do
        get '/web_guesser?rando=42&guess=53'
        expect(last_response.body).to include('Way too high!')
      end

      it 'tells the user a guess is way too low' do
        get '/web_guesser?rando=42&guess=30'
        expect(last_response.body).to include('Way too low!')
      end
    end

    context 'off by less than ten' do
      it 'tells the user a guess is too high' do
        get '/web_guesser?rando=42&guess=50'
        expect(last_response.body).to include('Too high!')
      end

      it 'tells the user a guess is too low' do
        get '/web_guesser?rando=42&guess=35'
        expect(last_response.body).to include('Too low!')
      end
    end
  end
end
