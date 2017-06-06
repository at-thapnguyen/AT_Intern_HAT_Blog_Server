require 'faker'

FactoryGirl.define do
  factory :user do
    id { Faker::Code }
    username { Faker::Name.unique.name }
    fullname { Faker::Name.name }
    avatar { Faker::Avatar}
    email { Faker::Internet.email }
    password "changeme"
    password_confirmation "changeme"
    description "no thing"
    token "hihi"
    access "true"
    blocked "false"
    access_token "d2et3ge3aeo4idrio0"
  end
end
