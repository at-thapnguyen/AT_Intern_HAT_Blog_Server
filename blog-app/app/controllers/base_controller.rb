class BaseController < ApplicationController


  # check_login: Use to check user did login? If did login, systems will allow to use privilege.
  # params:
  # => id: user_id
  # => access_token: access_token

  def check_login access_token
    user = User.find_by access_token: access_token
    return ( !user.blank? )? user : nil
  end

  # check_time_access: use to check user's access use did limited?
  # return:
  # => true: Must prevent use continues because over time. User must login again
  # => false: User continues use this session
  # 3 * 24 * 60 * 60 = 259200(s) : 3 days. Setup default time to user use this session

  def check_time_access id
    (User.find(id).updated_at + 259200 == Time.current.utc) ? true : false
  end

end