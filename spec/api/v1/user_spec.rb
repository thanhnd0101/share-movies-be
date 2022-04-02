require "rails_helper"

RSpec.describe Users, type: :request do
  describe "get /api/v1/users" do
    it "return empty list" do
      get "/api/v1/users"
      puts response
      expect(response.body).to eq("[]")
    end
  end

  describe "post /api/v1/users" do
    it "create successfully a new account" do
      allow(UseCases::Register).to receive(:new_account).and_return(double(:account, :id => 1, :username => "abc", :password => "bca"))

      post "/api/v1/users", :params => {:username => "abc", :password => "123"}
      expect(response).to redirect_to("/api/v1/users/login")
    end

    it "fail to create a new account" do
      allow(UseCases::Register).to receive(:new_account).and_return(nil)

      post "/api/v1/users", :params => {:username => "abc", :password => "123"}
      expect(response).to have_http_status(:conflict)
    end
  end

  describe "post /api/v1/users/login" do
    it "login successfully" do
      allow(UseCases::Login).to receive(:login_user).and_return({:auth_token => "1.1.1", :account_id => 123})

      post "/api/v1/users/login", :params => {:username => "abc", :password => "123"}
      expect(response).to have_http_status(:ok)
    end

    it "fail to login" do
      allow(UseCases::Login).to receive(:login_user).and_return(nil)

      post "/api/v1/users/login", :params => {:username => "abc", :password => "123"}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "post /api/v1/users/share-youtube-video" do
    it "share successfully a new youtube video" do
      allow_any_instance_of(Services::AuthorizeApiRequest).to receive(:call).and_return({id: '123'})
      allow(UseCases::ShareYoutubeVideo).to receive(:share_a_video).and_return(double(:account, :id => 1, :account_id => 1))

      post "/api/v1/users/share-youtube-video", :params => {:youtube_url => "https://www.youtube.com/watch?v=zQpfv4h3Rn4"}
      expect(response).to have_http_status(:ok)
    end

    it "fail to share a youtube video" do
      allow_any_instance_of(Services::AuthorizeApiRequest).to receive(:call).and_return(nil)

      post "/api/v1/users/share-youtube-video", :params => {:youtube_url => "https://www.youtube.com/watch?v=zQpfv4h3Rn4"}
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
