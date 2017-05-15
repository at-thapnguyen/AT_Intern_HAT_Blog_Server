class Api::V1::UsersController < BaseController
  def index
    # render json: JSONAPI::Serializer.serialize(users, is_collection: true)
    render json: User.all
  end

  def create
    user = User.create(user_params)
    if user.valid?
      UserMailer.registration_confirmation(user).deliver
      render json: user, meta: { message: "register success", status: 400 }
    else
      msg = { message: "Not Acceptable", code: 406 }
      render json: msg
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if !user.blank?
      user.email_activate
      token = SecureRandom.hex
      user.token = token
      user.update_attribute("access_token", token)
      msg = { status: "success", message: "Activated", code: 200}
      render json: user, meta: { message: "register success", status: 400 }
    else
      msg = { status: "unsuccess", message: "You must cofirm email", code: 406 }
      render json: msg
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation)
  end

end
