require 'faker'

FactoryGirl.define do
	factory :user do
	  username { Faker::Name.name }
	  password "changme"
	  email { Faker::Internet.email }
	  access "true"
	  blocked "true"
	  end
	end
