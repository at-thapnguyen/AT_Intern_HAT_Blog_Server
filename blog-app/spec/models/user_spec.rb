require 'rails_helper'

describe User do
  context 'Validations' do

    it "username dont't must blank" do
      should validate_presence_of(:username)
    end

    it "password don't must blank" do
      should validate_presence_of(:password)
    end

  end

  context 'Create is not valid' do
    before { @user = FactoryGirl.build(:user) }
    subject { @user }
    it "Create is not valid" do
      expect(@user).to be_valid
    end
  end

end