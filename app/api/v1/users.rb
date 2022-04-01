class Users < Grape::API
  desc 'End-points for user'

  get do
    Account.all.to_json
  end

  params do
    requires :username, type: String
    requires :password, type: String
  end
  post do
    account = UseCases::Register.new_account(params[:username], params[:password])

    if account.nil?
      status :conflict
      {
        errorMessage: "Duplicated username"
      }
    else
      redirect '/api/v1/users/login', username: params[:username], password: params[:password]
    end
  end

  namespace :login do

    params do
      requires :username, type: String
      requires :password, type: String
    end
    post do
      result = UseCases::Login.login_user(params[:username], params[:password])

      if result.present?
        status :ok
        {
          auth_token: result[:auth_token]
        }
      else
        status :unauthorized
      end
    end
  end
end