require 'rails_helper'
require 'spec_helper'

RSpec.describe Entities::Media do

  describe 'create_youtube_video' do
    it 'create media not successfull' do
      allow_any_instance_of(UploadMedia).to receive(:document=).and_return({})
      allow_any_instance_of(UploadMedia).to receive(:save!).and_raise(Exception)

      expect {Entities::Media.create_youtube_video({}, {})}.to raise_error(Exception)
    end

    it 'create media successfull' do
      expected_value = {id:1, url: 'aee.zuy', meta_data: {}}
      allow_any_instance_of(UploadMedia).to receive(:document=).and_return({})
      allow_any_instance_of(UploadMedia).to receive(:save!).and_return(expected_value)

      expect(Entities::Media.create_youtube_video({}, {})).to include_json(expected_value)
    end
  end
end
