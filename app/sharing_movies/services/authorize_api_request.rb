class Services::AuthorizeApiRequest < Services::Base

  def initialize(headers)
    super
    @headers = headers
  end

  def call
    account
  end
 
  def auth_token
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      Rails.logger.error("Missing token - #{__FILE__ }#{__LINE__ }")
    end
    nil
  end

  private

  attr_reader :headers

  def account
    @account ||= Account.find(@decoded_auth_token["account_id"]) if decoded_auth_token
    @account || Rails.logger.error("Invalid token - #{__FILE__ }#{__LINE__ }") && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(auth_token)
    @decoded_auth_token if @decoded_auth_token.present?
  end

 

end
