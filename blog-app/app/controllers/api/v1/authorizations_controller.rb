class Api::V1::AuthorizationsController < BaseController
  #User Login
  before_action :authentication!, only: [:update, :destroy]

  # confirm email for register
  def show
    user = User.with_deleted.find_by_confirm_token(params[:id])
    if !user.blank?
      user.email_activate
      msg = { status: "success", message: "Activated", code: 200}
      render json: user
    else
      msg = { status: "unsuccess", message: "You must cofirm email", code: 406 }
      render json: msg
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user.blank?
      render json: { errors: [ status: 400, message: [{ email: "Not match email" }] ]} #, status: :non_authoritative_information
    else
      if user.authenticate(params[:password]).blank?
        render json: { errors: [ status: 400, message: [{ password: "Not match password" }] ]}
      else
        token = SecureRandom.hex  + user.created_at.to_i.to_s + user.id.to_s
        user.access_token = token
        user.update_attribute "access_token", token
        render json: user
      end
    end
  end

  def update
    if @current_user.authenticate(params[:password_old])
      @current_user.update_attribute "password", params[:password_new]
      render json: { status: 200 }
    else
      render json: { errors: ['Not match password']}, meta: {status: 400 }
    end
  end

  #user Logout
  def destroy
    @current_user.update_attribute "access_token", nil
    render json: { status: 200 }
  end

  private
  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

end
