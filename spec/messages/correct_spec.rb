RSpec.describe Correct do
  before(:each) do
    allow(Kernel).to receive(:rand) { 42 }
    get '/web_guesser'
  end

  it 'tells the user a guess is correct' do
    get '/web_guesser?guess=42'
    expected_message = 'You got it right! Try again with a new number'
    expect(last_response.body).to include(expected_message)
  end

  it 'resets the guess count after' do
    get '/web_guesser?guess=42'
    expect(last_response.body).to include('5 guesses left!')
  end

  it 'generates another random number' do
    expect(Kernel).to receive(:rand).once
    get '/web_guesser?guess=42'
  end

  context 'params[:cheat]' do
    it 'displays the answer' do
      get '/web_guesser?cheat=true'
      expect(last_response.body).to include('THE ANSWER IS 42')
    end
  end
end
