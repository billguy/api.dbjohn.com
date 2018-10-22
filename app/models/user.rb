class User < ApplicationRecord

  attr_accessor :password

  validates_presence_of :name, :email
  validates_length_of :password, in: 6..20, on: :create

  before_save :encrypt_password

  MAX_ATTEMPTS=5

  def valid_password?(password)
    password.present? && BCrypt::Engine.hash_secret(password, salt)
  end

  def login!
    update_columns(last_login_at: DateTime.now, failed_attempts: 0)
  end

  def failed_login_attempt!
    self.failed_attempts = self.failed_attempts + 1
    self.locked_at = DateTime.now if locked_out?
    save
  end

  def locked_out?
    self.failed_attempts >= MAX_ATTEMPTS || self.locked_at.present?
  end

  def unlock!
    update_columns(locked_at: nil, failed_attempts: 0)
  end

  def disable!
    update_columns(locked_at: DateTime.now)
    session.flush_by_token(tokens[:refresh])
  end

  def session
    @session ||= JWTSessions::Session.new(payload: access_payload, refresh_payload: access_payload)
  end

  def access_payload
    { user_id: self.id }
  end

  def tokens
    @tokens ||= session.login
  end

  private

    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
      end
    end

end
