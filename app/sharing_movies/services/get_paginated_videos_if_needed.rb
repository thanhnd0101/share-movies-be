class Services::GetPaginatedVideosIfNeeded < Services::Base

  def initialize(opt={})
    @page_index = opt[:page_index]
    @items_per_page = opt[:items_per_page]
  end

  def call
    documents = Document.order(id: :desc).page(@page_index).per(@items_per_page).includes(:account, :upload_media)

    documents.map do |document|
      {
        username: document.account.username,
        document_id: document.id,
        media_type: document.upload_media.first.media_type,
        meta_data: JSON.parse(document.upload_media.first.meta_data),
        url: document.upload_media.first.url
      }
    end
  end
end
