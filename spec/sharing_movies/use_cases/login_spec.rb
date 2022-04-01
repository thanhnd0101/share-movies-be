require "rails_helper"
require 'spec_helper'

RSpec.describe "UseCases::Login" do
  describe "has an account" do
    it "should return auth_token and account_id" do
      expected_json = {auth_token: "aaa", account_id: 123}
      allow(Services::AuthenticateUser).to receive(:call).and_return(expected_json)

      expect(UseCases::Login.login_user('aaa', 'bbb')).to include_json(expected_json)
    end
  end

  describe "does not has any account" do
    it "should return nil" do
      allow(Services::AuthenticateUser).to receive(:call).and_return(nil)

      expect(UseCases::Login.login_user('aaa', 'bbb')).to be_nil
    end
  end
end
