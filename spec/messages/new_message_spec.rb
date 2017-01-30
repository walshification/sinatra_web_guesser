RSpec.describe NewMessage do
  before(:each) do
    allow(Kernel).to receive(:rand) { 42 }
  end

  it 'prompts the user for a guess' do
    get '/web_guesser'
    expect(last_response.body).to include('Guess a number between 0 and 100')
  end

  it 'gives the user 5 guesses' do
    get '/web_guesser'
    expect(last_response.body).to include('5 guesses left!')
  end

  context 'params[:cheat]' do
    it 'displays the answer' do
      get '/web_guesser?cheat=true'
      expect(last_response.body).to include('THE ANSWER IS 42')
    end
  end
end
