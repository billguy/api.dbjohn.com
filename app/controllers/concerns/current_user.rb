module CurrentUser
  extend ActiveSupport::Concern

  included do

    before_action :load_current_user, only: [:update, :create, :destroy]

    private

      def current_user
        @current_user ||= User.where(id: payload['user_id']).first or raise ActiveRecord::RecordNotFound
      end

      def load_current_user
        current_user
      end

  end
end