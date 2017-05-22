require 'faker'

FactoryGirl.define do
	factory :user do
		id { Faker::Code }
	  username { Faker::Name.unique.name }
    fullname { Faker::Name.name }
    access_token "454affsdf454hoisdfaadfk"
    token "hihi"
	  password "changeme"
	  email { Faker::Internet.email }
	  access "true"
	  blocked "true"
	end
end
