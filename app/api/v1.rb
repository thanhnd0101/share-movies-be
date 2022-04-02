class V1 < Grape::API

  mount Users => '/users'
  mount Videos => '/videos'
end
