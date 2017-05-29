module AuthorizationHelperSpec
  def get_access_token email
    User.find_by(email: email).access_token
  end
end