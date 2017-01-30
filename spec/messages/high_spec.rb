RSpec.describe High do
  before(:each) do
    allow(Kernel).to receive(:rand) { 42 }
    get '/web_guesser'
  end

  it 'counts down how many guesses are left' do
    get '/web_guesser?rando=42&guess=45'
    get '/web_guesser?rando=42&guess=45'
    expect(last_response.body).to include('3 guesses left!')
  end

  it 'tells the user a guess is too high' do
    get '/web_guesser?rando=42&guess=50'
    expect(last_response.body).to include('Too high!')
  end

  context 'after 5 guesses' do
    before(:each) do
      5.times do
        get '/web_guesser?rando=42&guess=45'
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
      get '/web_guesser?cheat=true'
      expect(last_response.body).to include('THE ANSWER IS 42')
    end
  end
end
