
module AuthorizationHelperSpec
  def create_record user
    user = User.create! username: user["username"],
                        email: user["email"],
                        password: user["password"],
                        password_confirmation: user["password_confirmation"],
                        access_token: SecureRandom.hex
    return user.access_token if user.valid?
  end
  def get_access_token email
    # @user ||= FactoryGirl.create(:user)
    User.find_by(email: email).access_token
  end
end