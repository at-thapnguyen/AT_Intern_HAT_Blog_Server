require 'rails_helper'
include AuthorizationHelperSpec

describe Api::V1::AuthorizationsController do
  describe "GET /api/v1/authorizations/:id" do
    describe "Get confirmation email successfully" do
    end
  end

  describe "POST /api/v1/authorizations" do
    describe "Login successfully" do

      let!(:user) { FactoryGirl.attributes_for :login_user}
      it "Status 200" do
        request.headers["HTTP_ACCESS_TOKEN"] = get_access_token user[:email]
        post :create, user
        expect(response).to be_success
      end

      it "Json response" do
        request.headers["HTTP_ACCESS_TOKEN"] = get_access_token user[:email]
        post :create, user
        json_response = JSON.parse(response.body)
        binding.pry
        # expect(json_response)
      end
    end
    describe "Login not successfully" do
      let!(:user) { FactoryGirl.attributes_for :login_user}
      it "Email not match" do
        post :create, { user: user }
        json_response = JSON.parse(response.body)
        errors_json = { errors: [ status: 400, message: [{ email: "Not match email" }] ]}
        # expect(json_response).to eql errors_json
      end

      it "Password not match" do
        post :create, { user: user }
        json_response = JSON.parse(response.body)
        errors_json = { errors: [ status: 400, message: [{ email: "Not match password" }] ]}
        # expect(json_response).to eql errors_json
      end
    end
  end
end
