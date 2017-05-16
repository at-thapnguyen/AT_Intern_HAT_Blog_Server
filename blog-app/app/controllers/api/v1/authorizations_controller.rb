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
        token = SecureRandom.hex  + user.created_at.to_i.to_s + user.id.to_s
        user.access_token = token
        user.update_attribute("access_token", token)
        render json: user
      end
    end
  end

  def update
    user = check_login response.request.env["HTTP_ACCESS_TOKEN"]
    if !user.blank?
      if user.authenticate(params[:password_old])
        user.password = params[:password_new]
        user.save!
        msg = { status: 200 }
        return render json: msg
      else
        msg = { status: 200 }
        return render json: msg
      end
    else
      render json: { errors: ['Not match password']}, meta: {status: 400 }
    end
  end

  #user Logout
  def destroy
    if (check_login params[:access_token] != nil) && (!check_time_access params[:id])
      User.find(params[:id]).update_columns(access_token: nil)
      msg = { status: 200 }
      return render json: msg
    else
      return render json: { errors: ['Authorization for this user!']}
    end
  end

  private
  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

end
