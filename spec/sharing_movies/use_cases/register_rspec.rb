require 'rails_helper'
require 'spec_helper'

RSpec.describe UseCases::Register do

  describe 'create_new_account' do
    it 'create user not successfull' do
      allow(Account).to receive(:create!).and_raise(ActiveRecord::RecordNotUnique)

      expect(Entities::User.create_new_account('1', '1')).to be_nil
    end

    it 'create user successfull' do
      expected_value = {id:1, username: '1', password: '1'}
      allow(Account).to receive(:create!).and_return(expected_value)

      expect(Entities::User.create_new_account('1', '1')).to include_json(expected_value)
    end
  end
end
