require "rails_helper"

RSpec.describe Videos, type: :request do

  describe "post /api/v1/videos/share-youtube-video" do
    it "share successfully a new youtube video" do
      allow_any_instance_of(Services::AuthorizeApiRequest).to receive(:call).and_return({id: '123'})
      allow(UseCases::ShareYoutubeVideo).to receive(:share_a_video).and_return(double(:account, :id => 1, :account_id => 1))

      post "/api/v1/users/share-youtube-video", :params => {:youtube_url => "https://www.youtube.com/watch?v=zQpfv4h3Rn4"}
      expect(response).to have_http_status(:ok)
    end

    it "fail to share a youtube video" do
      allow_any_instance_of(Services::AuthorizeApiRequest).to receive(:call).and_return(nil)

      post "/api/v1/users/share-youtube-video", :params => {:youtube_url => "https://www.youtube.com/watch?v=zQpfv4h3Rn4"}
      expect(response).to have_http_status(:unauthorized)
    end
  end
  end