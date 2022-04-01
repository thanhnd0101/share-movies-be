require 'rails_helper'

RSpec.describe 'JsonWebToken' do

  describe 'encode' do
    it 'return token' do
      expect(JsonWebToken.encode(account_id: '123')).not_to be_nil
    end
  end

  describe 'dencode' do
    it 'return token as expected' do
      token = JsonWebToken.encode(account_id: '123')
      expect(JsonWebToken.decode(token).keys).to contain_exactly('account_id', 'exp')
      expect(JsonWebToken.decode(token)['account_id']).to eq('123')
    end

    it 'raise error' do
      expect { JsonWebToken.decode('1.1.1') }.to raise_error(JWT::DecodeError)
    end
  end
end
