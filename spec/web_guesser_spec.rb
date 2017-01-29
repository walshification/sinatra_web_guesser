RSpec.describe "My Sinatra Application" do
  after(:each) do
    get '/reset'
  end

  describe '/web_guesser' do
    it 'allows accessing the web_guesser page' do
      get '/web_guesser'
      expect(last_response).to be_ok
    end

    it 'prompts the user for a guess' do
      get '/web_guesser'
      expect(last_response.body).to include('Guess a number between 0 and 100')
    end

    it 'tells the user a guess is correct' do
      get '/web_guesser?rando=42&guess=42'
      expected_message = 'You got it right! Try again with a new number'
      expect(last_response.body).to include(expected_message)
    end

    it 'gives the user 5 guesses' do
      get '/web_guesser'
      expect(last_response.body).to include('5 guesses left!')
    end

    it 'counts down how many guesses are left' do
      get '/web_guesser?rando=42&guess=1'
      get '/web_guesser?rando=42&guess=1'
      expect(last_response.body).to include('3 guesses left!')
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

    context 'after 5 guesses' do
      before(:each) do
        5.times do
          get '/web_guesser?rando=42&guess=10'
        end
      end

      it 'tells players they lost' do
        expected = 'Nice try! The number was 42. Try again with a new number'
        expect(last_response.body).to include(expected)
      end

      it 'resets the guess count after' do
        expect(last_response.body).to include('5 guesses left!')
      end
    end

    context 'params[:cheat]' do
      it 'displays the answer' do
        get '/web_guesser?cheat=true&rando=42'
        expect(last_response.body).to include('THE ANSWER IS 42')
      end
    end
  end
end
