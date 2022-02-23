ENV['APP_ENV'] = 'test'

require '../code/hw.rb'
require 'test/unit'
require 'rack/test'

class BAHWTest < Test::Unit::TestCase

  def test_it_underCamelizes
    assert_equal underCamelize('aaa-BBB-cCc-dDD') , 'aaaBbbCccDdd'
  end
  def test_it_transforms
    browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
    browser.get '/' , :transform=>'aaa-BBB-cCc-dDD'
    assert browser.last_response.ok?
    assert_equal 'aaaBbbCccDdd', browser.last_response.body
  end

  def test_it_doesnt_break_from_numbers
    browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
    browser.get '/' , :transform=>'12345'
    assert browser.last_response.body.include?('12345')
  end
end