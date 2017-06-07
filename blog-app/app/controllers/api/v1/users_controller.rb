class Api::V1::UsersController < BaseController

  before_action :authentication!, only: [:update]
  # before_action :update, :if => authentication!
  # before_action :update?, :if => authentication != nil

  def index
    render json: User.all
  end

  def show
    user = User.find_by_username params[:username]
    render json: user
  end

  def create
    user = User.new user_params
    if user.valid?
      token = SecureRandom.hex
      user.access_token = token
      user.avatar = "/uploads/avatar/default-avatar.png"
      user.blocked = true
      user.save
      # UserMailer.registration_confirmation(user).deliver
      render json: user
    else
      render json: {errors: [ status: 400, message: [ user.errors.messages ]]}, status: :unauthorized
    end
  end

  def update
    if params[:avatar].class == String
      @current_user.fullname = params[:fullname]
      @current_user.description = params[:description]
      @current_user.birthday = params[:birthday]
      @current_user.save
    else
      #Handle rename filename uploaded to user_id.typefile
      params[:avatar].original_filename = rename_file params[:avatar].original_filename, @current_user.id
      @current_user.fullname = params[:fullname]
      @current_user.description = params[:description]
      @current_user.birthday = params[:birthday]
      @current_user.avatar = "/uploads/avatar/"+ params[:avatar].original_filename
      if @current_user.valid?
        @current_user.save
        uploader = AvatarUploader.new
        uploader.store!(params[:avatar])
      else
        render json: { errors: [ status: 400, message: [ @current_user.errors.messages ]]}
      end
    end
    render json: current_user,serializer: UserSerializer
  end

  def detroy
    blocked_user = User.with_deleted.find params[:id]
    blocked_user.update_columns blocked: 1
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
    params.permit(:username, :email, :password, :password_confirmation, :birthday)
  end

end
