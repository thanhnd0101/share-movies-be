require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe UpdateYoutubeVideosMetadataJob do
  let!(:document) { double }
  let!(:documents) { double }
  let!(:upload_media) { double }

  describe 'perform' do
    before do
      stub_const('ENV', {'VIDEO_UPDATE_PERIOD_THRESHOLD_IN_HOURS' => 1})
      expect(Document).to receive(:id_list).and_return(Document)
      expect(Document).to receive(:includes).and_return([document])
      allow(document).to receive(:upload_media).and_return(upload_media)
      allow(upload_media).to receive(:first)
      allow_any_instance_of(GetYoutubeVideoInfo).to receive(:call).and_return({})
      allow(upload_media).to receive(:update)

    end

    it 'perform update medata in the background', factory: :stub do
      allow(upload_media).to receive(:updated_at).and_return(Time.now - 4000)

      UpdateYoutubeVideosMetadataJob.perform_async([1,1,3])

      expect(upload_media).to have_received(:update).with({meta_data:{}})
    end

    it 'perform update medata in the background', factory: :stub do
      allow(upload_media).to receive(:updated_at).and_return(Time.now)
      UpdateYoutubeVideosMetadataJob.perform_async([1,2,3])

      expect(upload_media).not_to have_received(:update)
    end
  end
end
