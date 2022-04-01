class Services::AuthenticateUser < Services::Base

  def initialize(username, password)
    super
    @username = username
    @password = password
  end

  def call
    @token = JsonWebToken.encode(user_id: account.id) if account
    if @token.present?
      return {
        auth_token: @token,
        account_id: account.id
      }
    end
    nil
  end

  private

  attr_reader :password, :username

  def account
    @account ||= Account.find_by(username: username)
    return @account if @account.try(:authenticate, password)

    nil
  end
end
