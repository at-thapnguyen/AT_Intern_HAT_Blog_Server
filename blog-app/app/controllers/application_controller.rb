
class ApplicationController < ActionController::Base
  attr_reader :current_account

    protected
    def authenticate_request!
      unless account_id_in_token?
        render json: { errors: ['Not Authenticated'] }, status: :unauthorized
        return
      end
      binding.pry
      @current_account = Account.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end

    private
    def http_token
        @http_token ||= if request.headers['Authorization'].present?
          request.headers['Authorization'].split(' ').last
        end
    end

    def auth_token
      @auth_token ||= JsonWebToken.decode(http_token)
    end

    def account_id_in_token?
      http_token && auth_token && auth_token[:user_id].to_i
    end
end