ENV['APP_ENV'] = 'test'

require '../code/hw.rb'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

RSpec.describe 'BAHW App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "Does the Deed of underCameled Transformation" do
    get '' , :transform=>'aaa-BBB-cCc-dDD'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('aaaBbbCccDdd')
  end

end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end