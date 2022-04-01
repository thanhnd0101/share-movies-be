require 'rails_helper'

RSpec.describe 'Services::AuthenticateUser' do
  describe 'has an account' do
    it 'should return auth_token and account_id' do
      service = Services::AuthenticateUser.new('abc', 'bca');
      allow(service).to receive(:account).and_return(double(:account, :id => 1, :username => 'abc', :password => 'bca'))

      expect(service.call.keys).to contain_exactly(:account_id, :auth_token)
    end
  end

  describe 'does not has any account' do
    it 'should return nil' do
      service = Services::AuthenticateUser.new('abc', 'bca');
      allow(service).to receive(:account).and_return(nil)

      expect(service.call).to be_nil
    end
  end
end
