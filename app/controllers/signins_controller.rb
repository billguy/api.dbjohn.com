class SigninsController < ApplicationController

  before_action :authorize_access_request!, only: [:destroy]

  def create
    user = User.where(email: params[:email]).first or (login_incorrect and return)
    raise UserLockedOut if user.locked_out?

    if user.valid_password?(params[:password])
      user.login!
      tokens = user.tokens
      render json: tokens.merge(user.access_payload)
    else
      user.failed_login_attempt!
      render json: { error: "Invalid email/password" }, status: :forbidden
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: {}, status: :ok
  end

  private

    def login_incorrect
      render json: { error: 'Incorrect User/Password' }, status: :unauthorized
    end

end