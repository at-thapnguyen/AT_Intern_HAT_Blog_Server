require 'rails_helper'
# require "spec_helper"

describe Api::V1::UsersController, :type => :api do

  describe "/api/v1/users/:user_id" do
    let!(:user) { FactoryGirl.create :user }
    it "status success" do
      binding.pry
      get :show, id: user.id
      expect(response).to be_success
    end

  end

end