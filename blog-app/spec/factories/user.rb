require 'faker'

FactoryGirl.define do
	factory :user do
		id { Faker::Code }
	  username { Faker::Name.unique.name }
    fullname { Faker::Name.name }
    token "hihi"
    description "no thing"
    avatar { Faker::Avatar}
	  password "changeme"
	  email { Faker::Internet.email }
	  access "true"
	  blocked "false"
	end
end
