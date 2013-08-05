require 'test_helper'

describe OmniAuth::Strategies::VK do
  let(:access_token) { stub('AccessToken', options: {}) }
  let(:parsed_response) { stub('ParsedResponse') }
  let(:response) { stub('Response', parsed: parsed_response) }

  subject do
    OmniAuth::Strategies::VK.new('VK_APP_ID', 'VK_SECRET_KEY')
  end

  before(:each) do
    # subject.stubs(access_token).returns(access_token)
  end

  describe "client options" do
    it "should have correct site" do
      subject.options.client_options.site.must_equal "https://oauth.vk.com"
    end

    it "should have correct autorize url" do
      subject.options.client_options.authorize_url.must_equal "/authorize"
    end

    it "should have correct token url" do
      subject.options.client_options.token_url.must_equal "/access_token"
    end
  end

  describe "default options" do

    %w(scope logger info_proc).each do |method|
      it "should have no #{method}" do
        subject.options.send(method).must_be_nil
      end
    end

    it "should have display set to popup" do
      subject.options['display'].must_equal 'popup'
    end

    it "should have version" do
      subject.options.v.wont_be :nil?
    end

  end

end
