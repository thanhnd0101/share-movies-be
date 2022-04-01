class UseCases::Register

  def self.new_user(username, password)

    Entities::User.create_new_user(username, password)
  end
end
