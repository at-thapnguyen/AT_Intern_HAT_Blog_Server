

module UserHelperSpec
  def except_user user
    user.attributes.except('blocked', 'created_at', 'updated_at', 'password_digest',
          'email_confirmed', 'confirm_token', 'birthday', 'access')
  end
end
# RSpec.configure do |config|
#   config.include ApiHelper, :type=>:api #apply to all spec for apis folder
# end