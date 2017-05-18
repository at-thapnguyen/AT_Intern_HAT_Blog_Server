class Api::V1::AuthorizationsController < BaseController

  #User Login
  def create
    user = User.find_by(email: params[:email])
    if user.blank?
      render json: { errors: [ status: 400, message: [{ valid: "Not match email" }] ]}
    else
      if user.authenticate(params[:password]).blank?
        render json: { errors: [ status: 400, message: [{ valid: "Not match password" }] ]}
      else
        token = SecureRandom.hex  + user.created_at.to_i.to_s + user.id.to_s
        user.access_token = token
        user.update_attribute("access_token", token)
        render json: user
      end
    end
  end

  def update
    user = check_login
    if !user.blank?
      if user.authenticate(params[:password_old])
        user.password = params[:password_new]
        user.save!
        render json: { status: 200 }
      else
        render json: { errors: ['Not match password']}, meta: {status: 400 }
      end
    else
      render json: { errors: [ status: 400, message: [{ valid: "Authorization for this user!" }] ]}
    end
  end

  #user Logout
  def destroy
    user = check_login
    if !check_login.blank?
      user.access_token = nil
      user.save
    else
      render json: { errors: [ status: 400, message: [{ valid: "Authorization for this user!" }] ]}
    end
  end

  private
  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

end
