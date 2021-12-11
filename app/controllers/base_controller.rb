class BaseController < ApplicationController

  include CurrentUser

  before_action :authorize_access_request!, only: [:create, :update, :destroy]

end