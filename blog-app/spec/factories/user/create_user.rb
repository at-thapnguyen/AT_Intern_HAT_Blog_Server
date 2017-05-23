require 'faker'

FactoryGirl.define do
  factory :create_user do
    password "changeme"
    email { Faker::Internet.email }
    password_confirmation "changeme"
  end
end