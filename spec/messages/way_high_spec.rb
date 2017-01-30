RSpec.describe WayHigh do
  before(:each) do
    allow(Kernel).to receive(:rand) { 42 }
    get '/web_guesser'
  end

  it 'tells the user a guess is way too high' do
    get '/web_guesser?rando=42&guess=53'
    expect(last_response.body).to include('Way too high!')
  end

  it 'counts down how many guesses are left' do
    get '/web_guesser?rando=42&guess=99'
    get '/web_guesser?rando=42&guess=99'
    expect(last_response.body).to include('3 guesses left!')
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
