class Api::V1::UsersController < BaseController
  def index
    # render json: JSONAPI::Serializer.serialize(users, is_collection: true)
    render json: User.all
  end

  def create
    user = User.create(user_params)
    if user.valid?
      UserMailer.registration_confirmation(user).deliver
      render json: user
    else
      render json: { errors: [ status: 400, message: [{ valid: "Email uniqueness" }] ]}
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if !user.blank?
      user.email_activate
      token = SecureRandom.hex
      user.token = token
      user.update_attribute("access_token", token)
      user.update_columns(blocked: false)
      msg = { status: "success", message: "Activated", code: 200}
      render json: user
    else
      msg = { status: "unsuccess", message: "You must cofirm email", code: 406 }
      render json: msg
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = check_login
    if !user.blank?
      #Handle rename filename uploaded to user_id.typefile
      params[:user][:avatar].original_filename = rename_file params[:user][:avatar].original_filename, user.id
      user.fullname = params[:user][:fullname]
      user.username = params[:user][:username]
      user.description = params[:user][:description]
      user.avatar = params[:user][:avatar]
      user.save
      render json: { status: 200 }
    else
      render json: { status: "unsuccess", message: "You must cofirm email", code: 406 }
    end
  end

  private

  # rename_file: rename file upload to user_id.*
  # params:
  # => filename: filename uploaded
  # => change_name: Name then you want rename (user_id.*)

  def rename_file filename, change_name
    binding.pry
    change_name.to_s + filename[filename.rindex(/\./)..filename.size].downcase
  end

  def user_params
    params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation)
  end

end
