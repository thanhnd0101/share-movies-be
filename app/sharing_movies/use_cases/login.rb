class UseCases::Login

  def self.login_user(username, password)
    Services::AuthenticateUser.call(username, password)
  end
end
