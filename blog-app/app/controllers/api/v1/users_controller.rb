class Api::V1::UsersController < ApplicationController
  def index
    # render json: JSONAPI::Serializer.serialize(users, is_collection: true)
    render json: User.all
  end

  def create
    @user = User.create(user_params)
    if params[:user][:password_confirmation] != @user.password
      msg = { status: "unsuccess", message: "Unauthorized", code: 401 }
      render json: msg
    else
      if @user.valid?
        UserMailer.registration_confirmation(@user).deliver
        render json: @user
      else
        msg = { status: "unsuccess", message: "Not Acceptable", code: 406 }
        render json: msg
      end
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user_params
      user.email_activate
      msg = { status: "success", message: "Activated", code: 200}
      render json: msg
    else
      msg = { status: "unsuccess", message: "You must cofirm email", code: 406 }
      render json: msg
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :username, :email, :password)
  end

end
class Api::V1::UsersController < ApplicationController
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
      msg = { status: "success", message: "Activated", code: 200}
      render json: msg
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
