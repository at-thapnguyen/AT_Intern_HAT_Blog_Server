class Api::V1::NotificationUsersController < BaseController
  before_action :authentication!, only: [:index]
  def index
    render json:  { users: { count_notifications: current_user.count_notifications }}
  end
end
