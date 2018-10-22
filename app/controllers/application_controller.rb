class ApplicationController < ActionController::API

  include JWTSessions::RailsAuthorization

  serialization_scope :view_context # AMS uses current_user but current_user may not be available

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from UserLockedOut, with: :locked_out

  private

    def not_authorized
      render json: { error: 'Not authorized' }, status: :unauthorized
    end

    def not_found
      render json: { error: 'Not found' }, status: :not_found
    end

    def locked_out
      render json: { error: 'This account has been locked for security purposes' }, status: :forbidden
    end

end
