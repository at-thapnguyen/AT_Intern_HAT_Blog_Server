class UserController < ApplicationController
  before_filter :authenticate_request!

  def index
    # render json: {'logged_in' => true}
    # users = User.all
    # render json: users
    # render json: payload("user")
  end

  def show

  end

end
