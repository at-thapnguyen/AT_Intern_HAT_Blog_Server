# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  fullname        :string(255)
#  username        :string(255)
#  email           :string(255)
#  avatar          :string(255)
#  description     :string(255)
#  password_digest :string(255)
#  access_token    :string(255)
#  confirm_token   :string(255)
#  birthday        :date
#  access          :boolean          default("0")
#  blocked         :boolean          default("1")
#  email_confirmed :boolean          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Authorization < User
end
