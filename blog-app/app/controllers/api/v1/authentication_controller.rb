class AuthenticationController < ApplicationController
  def authenticate_user
    acount = Account.find_for_database_authentication(email: params[:email])
    if acount.valid_password?(params[:password])
      render json: payload(acount)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private

  def payload(account)
    return nil unless account and account.id
    {
      auth_token: JsonWebToken.encode({account_id: account.id}),
      account: {id: account.id, email: account.email}
    }
  end
end