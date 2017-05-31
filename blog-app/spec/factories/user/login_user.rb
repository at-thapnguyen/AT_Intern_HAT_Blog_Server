require 'faker'

FactoryGirl.define do
  factory :login_user, class: User do
    email { Faker::Internet.email }
    # email "nhuy387@gmail.com"
    password "changeme"
  end
end