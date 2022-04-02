class Videos < Grape::API
  desc 'End-points for videos'

  params do
    optional :page_index, type: Integer
    optional :items_per_page, type: Integer
  end
  get do
    service = Services::AuthorizeApiRequest.new(request.headers)
    account = service.call
    if account.present?
      status :ok
      Services::GetPaginatedVideosIfNeeded.call({page_index: params[:page_index], items_per_page: params[:items_per_page]})
    else
      status :unauthorized
    end
  end

  namespace "share-youtube-video" do
    params do
      requires :youtube_url, type: String
    end
    post do
      service = Services::AuthorizeApiRequest.new(request.headers)
      account = service.call
      if account.present?
        document = UseCases::ShareYoutubeVideo.share_a_video(Entities::User.new(account, service.auth_token), params[:youtube_url])

        status :ok
        document.to_json
      else
        status :unauthorized
      end
    end
  end
end
