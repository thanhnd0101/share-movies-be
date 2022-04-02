require 'rails_helper'

RSpec.describe Entities::Document do

  describe 'create_youtube_video' do
    it 'create video not successfull' do
      allow(Entities::Document).to receive(:create_a_document).and_return(nil)

      expect(Entities::Document.create_youtube_video({account:{}}, {})).to be_nil
    end

    it 'create video successfull' do
      expected_value = {id:1, account_id: 1}
      allow(Entities::Document).to receive(:create_a_document).and_return(expected_value)
      allow(Entities::Media).to receive(:create_youtube_video).and_return(expected_value)

      expect(Entities::Document.create_youtube_video({account:{}}, {})).to include_json(expected_value)
    end
  end
end
