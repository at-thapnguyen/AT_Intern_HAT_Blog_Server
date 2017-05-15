require 'faker'
# FactoryGirl.define do
# 	factory :user do |f|
# 		f.username { FFaker::Name.name}
# 		# f.email { FFaker::Internet.email}
# 		f.password  {"123456666"}
# 		f.password_confirmation {"123456666"}
# 	end
# end

FactoryGirl.define do  
	factory :user do   
	 username { FFaker::Name.name }   
	  password "changme"    
	  email { FFaker::Internet.email }  
	  access "true"
	  blocked "true"
	  end
	end
