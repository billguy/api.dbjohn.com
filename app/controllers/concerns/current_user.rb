module CurrentUser
  extend ActiveSupport::Concern

  included do

    private

      def current_user
        token? ? User.where(id: token_payload['user_id']).first : nil
      end

      def token
        @token ||= request_headers['Authorization'].to_s.split(' ').last || request_cookies['Authorization']
      end

      def token?
        token.present?
      end

      def token_payload
        JWTSessions::Token.decode(token, {}).first
      end

  end
end