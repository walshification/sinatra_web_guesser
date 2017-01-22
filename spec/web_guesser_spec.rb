RSpec.describe "My Sinatra Application" do
  describe '/web_guesser' do
    it "allows accessing the web_guesser page" do
      get '/web_guesser'
      expect(last_response).to be_ok
    end

    it 'generates a random number between 0 and 100' do
      get '/web_guesser'
      expect(/.*The SECRET NUMBER is [0-9]{1}[0-9]?[0]?\..*/.match(last_response.body)).to be_truthy
    end
  end
end
