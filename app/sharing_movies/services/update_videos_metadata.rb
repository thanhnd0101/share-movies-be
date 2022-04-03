class Services::UpdateVideosMetadata < Services::Base

  def initialize(document_ids)
    @document_ids = document_ids
  end

  def call
    UpdateYoutubeVideosMetadataJob.perform_async(@document_ids)
  end

end
