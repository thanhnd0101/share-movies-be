require "rails_helper"

RSpec.describe "GetYoutubeVideoInfo" do

  describe "has data" do
      it "should return data as expected" do
        # Setup successful response
        response = Net::HTTPSuccess.new(1.0, "200", "OK")
        # Setup Net::HTTP to receive the response
        expect_any_instance_of(Net::HTTP).to receive(:request) { response }
        body = {
          "items": [
            {
              "id": "zQpfv4h3Rn4",
              "snippet": {
                "title": "abcefj",
                "description": "1234"
              },
              "statistics": {
                "viewCount": "759392",
                "likeCount": "9170",
                "favoriteCount": "0",
                "commentCount": "559"
              }
            }
          ]
        }
        expect(response).to receive(:body) { JSON.generate(body)}

        result = GetYoutubeVideoInfo.call("https://www.youtube.com/watch?v=xyz")
        expect(result).to include_json({
                                         "title": "abcefj",
                                         "description": "1234",
                                         "viewCount": "759392",
                                         "likeCount": "9170",
                                         "favoriteCount": "0",
                                         "commentCount": "559"
                                       })
      end
    end


  describe "has no items" do
    it "should return default values" do
      # Setup successful response
      response = Net::HTTPSuccess.new(1.0, "200", "OK")
      # Setup Net::HTTP to receive the response
      expect_any_instance_of(Net::HTTP).to receive(:request) { response }
      body = {
        "items": []
      }
      expect(response).to receive(:body) { JSON.generate(body)}

      result = GetYoutubeVideoInfo.call("https://www.youtube.com/watch?v=xyz")
      expect(result).to include_json({
                                       "title": "",
                                       "description": "",
                                       "viewCount": "",
                                       "likeCount": "",
                                       "favoriteCount": "",
                                       "commentCount": ""
                                     })
    end
  end


  describe "has expception" do
    it "should return defatul values" do
      # Setup successful response
      response = Net::HTTPSuccess.new(1.0, "200", "OK")
      # Setup Net::HTTP to receive the response
      expect_any_instance_of(Net::HTTP).to receive(:request) { response }
      body = {}
      expect(response).to receive(:body) { JSON.generate(body)}

      result = GetYoutubeVideoInfo.call("https://www.youtube.com/watch?v=xyz")
      expect(result).to include_json({
                                       "title": "",
                                       "description": "",
                                       "viewCount": "",
                                       "likeCount": "",
                                       "favoriteCount": "",
                                       "commentCount": ""
                                     })
    end
  end
end
