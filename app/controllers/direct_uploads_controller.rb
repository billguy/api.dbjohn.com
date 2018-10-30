class DirectUploadsController < ActiveStorage::DirectUploadsController

  include JWTSessions::RailsAuthorization

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authorize_access_request!

end