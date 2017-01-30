RSpec.describe "My Sinatra Application" do
  describe 'GET /web_guesser' do
    it 'allows accessing the web_guesser page' do
      get '/web_guesser'
      expect(last_response).to be_ok
    end

    it 'crafts a message with params and session' do
      fake_message = double('fake message')
      allow(fake_message).to receive(:session) { {} }
      allow(fake_message).to receive(:color)
      allow(fake_message).to receive(:guesses)
      allow(fake_message).to receive(:message)
      allow(fake_message).to receive(:cheat)

      expect(MessageCrafter).to receive(:for) { fake_message }
      get '/web_guesser?param=foo'
    end
  end
end
