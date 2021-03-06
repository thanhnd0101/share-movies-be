require "rails_helper"

RSpec.describe Videos, type: :request do

  describe "post /api/v1/videos/share-youtube-video" do
    it "share successfully a new youtube video" do
      allow_any_instance_of(Services::AuthorizeApiRequest).to receive(:call).and_return({id: '123'})
      allow(UseCases::ShareYoutubeVideo).to receive(:share_a_video).and_return(double(:account, :id => 1, :account_id => 1))

      post "/api/v1/videos/share-youtube-video", :params => {:youtube_url => "https://www.youtube.com/watch?v=zQpfv4h3Rn4"}
      expect(response).to have_http_status(:ok)
    end

    it "fail to share a youtube video" do
      allow_any_instance_of(Services::AuthorizeApiRequest).to receive(:call).and_return(nil)

      post "/api/v1/videos/share-youtube-video", :params => {:youtube_url => "https://www.youtube.com/watch?v=zQpfv4h3Rn4"}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "get /api/v1/videos" do
    it "get videos list with pagination" do
      allow(Entities::Document).to receive(:total_documents_count).and_return(21)
      allow_any_instance_of(Services::GetPaginatedVideosIfNeeded).to receive(:call).and_return({})

      get "/api/v1/videos?page_index=1&items_per_page=10"
      expect(response.body).to include_json({
                                         total_pages: 3,
                                         items_per_page: 10,
                                         documents: {} 
                                       })
    end

    it "get videos list without items_per_page" do
      allow(Entities::Document).to receive(:total_documents_count).and_return(21)
      allow_any_instance_of(Services::GetPaginatedVideosIfNeeded).to receive(:call).and_return({})

      get "/api/v1/videos?page_index=1"
      expect(response.body).to include_json({
                                              total_pages: 1,
                                              items_per_page: nil,
                                              documents: {}
                                            })
    end

    it "get videos list without page_index" do
      allow(Entities::Document).to receive(:total_documents_count).and_return(21)
      allow_any_instance_of(Services::GetPaginatedVideosIfNeeded).to receive(:call).and_return({})

      get "/api/v1/videos?items_per_page=10"
      expect(response.body).to include_json({
                                              total_pages: 3,
                                              items_per_page: 10,
                                              documents: {}
                                            })
    end
  end
end