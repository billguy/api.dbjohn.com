class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :last_login_at, :locked_at, :last_login_ip, :failed_attempts, :created_at, :updated_at
end
