class Api::V1::AuthorizationsController < BaseController

  #User Login
  def create
    user = User.find_by(email: params[:email])
    if user.blank?
      render json: { errors: ['Not match email']}, status: :unauthorized
    else
      if user.authenticate(params[:password]).blank?
        render json: { errors: ['Not match password']}, meta: {status: 400 }
      else
        token = SecureRandom.hex
        user.token = token
        user.update_attribute("access_token", token)
        render json: user
      end
    end
  end

  #user Logout

  def destroy
    if check_login (params[:id], params[:access_token]) && (!check_time_access)
      User.find(params[:id]).update_columns(access_token: nil)
      msg = { status: 200 }
      render json: msg
    else
      render json: { errors: ['Authorization for this user!']}
    end
  end

  private
  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

end
