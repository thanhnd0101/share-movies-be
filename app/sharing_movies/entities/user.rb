class Entities::User

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
