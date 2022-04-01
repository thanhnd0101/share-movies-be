class Entities::User

  def self.create_new_user(username, password)

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
