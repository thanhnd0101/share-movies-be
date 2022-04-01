class UseCases::Register

  def self.new_account(username, password)
    Entities::User.create_new_account(username, password)
  end
end
