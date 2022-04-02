require "uri"
require "net/http"

class GetYoutubeVideoInfo < Services::Base

  def initialize(youtube_url)
    @youtube_params = CGI::parse(URI::parse(youtube_url).query)
  end

  def call
    set_up
    begin
      res = Net::HTTP.get_response(@api_uri)
      data = JSON.parse(res.body)["items"][0]
      {
        title: data["snippet"]["title"],
        description: data["snippet"]["description"],
        viewCount: data["statistics"]["viewCount"],
        likeCount: data["statistics"]["likeCount"],
        favoriteCount: data["statistics"]["favoriteCount"],
        commentCount: data["statistics"]["commentCount"],
      }
    rescue => exp
      puts exp
      {
        title: "",
        description: "",
        viewCount: "",
        likeCount: "",
        favoriteCount: "",
        commentCount: "",
      }
    end
  end

  private

  def set_up
    @api_uri = URI("https://youtube.googleapis.com/youtube/v3/videos?part=snippet&part=statistics&id=#{@youtube_params["v"][0]}&key=AIzaSyDznEPmUcIBf8co8dHgd3AI3c-S0xrRJNs")
  end

end
