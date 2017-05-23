class Api::V1::UsersController < BaseController

  before_action :authentication!, only: [:update]

  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    @user = User.new user_params
    if @user.valid?
      token = SecureRandom.hex  + @user.created_at.to_i.to_s + @user.id.to_s
      @user.access_token = token
      @user.avatar = "http://localhost:3000/uploads/avatar/default-avatar.png"
      @user.blocked = true
      @user.save
      UserMailer.registration_confirmation(@user).deliver
      render json: @user
    else
      render json: { errors: [ status: 400, message: [ @user.errors.messages ]]}
    end
  end

  def update
    if @current_user.present?
      #Handle rename filename uploaded to user_id.typefile
      params[:user][:avatar].original_filename = rename_file params[:user][:avatar].original_filename, @current_user.id
      @current_user.fullname = params[:user][:fullname]
      @current_user.description = params[:user][:description]
      @current_user.birthday = params[:user][:birthday]
      @current_user.avatar = "http://localhost:3000/uploads/avatar/"+ params[:user][:avatar].original_filename
      if @current_user.valid?
        @current_user.save
        uploader = AvatarUploader.new
        uploader.store!(params[:user][:avatar])
      else
        render json: { errors: [ status: 400, message: [ @current_user.errors.messages ]]}
      end
      render json: { status: 200 }
    else
      render json: auth_error
    end
  end

  private

  # rename_file: rename file upload to user_id.*
  # params:
  # => filename: filename uploaded
  # => change_name: Name then you want rename (user_id.*)

  def rename_file filename, change_name
    change_name.to_s + filename[filename.rindex(/\./)..filename.size].downcase
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :birthday)
  end

end
