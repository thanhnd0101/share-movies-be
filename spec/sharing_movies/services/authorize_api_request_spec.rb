require 'rails_helper'

RSpec.describe 'Services::AuthorizeApiRequest' do
  describe "has authen token" do
    it "should return account" do
      service = Services::AuthorizeApiRequest.new({})
      allow(service).to receive(:decoded_auth_token).and_return('abc')
      allow(Account).to receive(:find).and_return(double(:account, id: 1))

      expect(service.call).not_to be_nil
    end
  end

  describe "has no authen token" do
    it "should return nil" do
      service = Services::AuthorizeApiRequest.new({})
      allow(service).to receive(:decoded_auth_token).and_return(nil)

      expect(service.call).to be_nil
    end
  end
end

