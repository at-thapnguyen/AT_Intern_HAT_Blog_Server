require 'rails_helper'
include UserHelperSpec

describe Api::V1::UsersController do

  describe "GET /api/v1/users" do
    let!(:user) { FactoryGirl.create :user }
    it "status success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET /api/v1/users/:username" do
    let!(:user) { FactoryGirl.create :user }
    it "Status 200" do
      get :show, username: user.username
      expect(response).to be_success
    end

    it "Returns the information personal" do
      get :show, username: user.username
      user_response = JSON.parse(response.body)
      expect(user_response['user'].except('birthday')).to eql except_user user
    end
  end

  describe "POST /api/v1/users" do
    describe "when create new user is successfully" do
      let!(:user) { FactoryGirl.attributes_for :user }
      it "Status 200" do
        post :create, params: user
        expect(response).to be_success
      end

      it "returns the information personal" do
        post :create, params: user
        user_response = JSON.parse(response.body)
        expect(user_response["user"].slice("username", "email").symbolize_keys).to eql user.slice(:username, :email)
      end
    end
  end

end
