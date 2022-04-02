class Entities::User

  def initialize(account, token)
    @account = account
    @token = token
  end

  def account
    @account
  end

  def self.create_new_account(username, password)
    begin
      Account.create!({
        username: username,
        password: password
      })
    rescue Exception => exp
      puts exp
      nil
    end
  end

end
