require 'rails_helper'

describe User, type: :model do
  let(:user) { FactoryGirl.create(:user)}
  describe "validations" do
  	it { binding.pry }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:access)}
    it { should validate_presence_of(:blocked)}
    it { should validate_length_of(:password) }
  end
end