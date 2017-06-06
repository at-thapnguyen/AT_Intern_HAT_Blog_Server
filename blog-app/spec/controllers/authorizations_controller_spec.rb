require 'rails_helper'
include AuthorizationHelperSpec


describe Api::V1::AuthorizationsController do
  describe "GET /api/v1/authorizations/:id" do
    describe "Get confirmation email successfully" do

    end
  end

  describe "POST /api/v1/authorizations" do
    describe "Login successfully" do

      let!(:user) do
        FactoryGirl.build :user
      end

      it "Status 200" do
        # request.headers["HTTP_ACCESS_TOKEN"] = get_access_token user[:email]
        create_record user.slice("username", "email", "password", "password_confirmation")
        post :create, params: user.slice("username", "email")
        expect(response).to be_success
      end

      it "Json response" do
        post :create, params: user.slice("username", "email", "password", "password_confirmation")
        json_response = JSON.parse(response.body)
        # expect(json_response)
      end
    end
    describe "Login not successfully" do
      let!(:user) { FactoryGirl.build :user}
      it "Email not match" do
        user.email = user.email + "ahihi"
        post :create, params: user.slice("username", "email", "password", "password_confirmation")
        json_response = JSON.parse(response.body)
        errors_json = { errors: [ status: 400, message: [{ email: "Not match email" }] ]}
        # expect(json_response).to eql errors_json
      end

      it "Password not match" do
        post :create, params: user.slice("username", "email", "password", "password_confirmation")
        json_response = JSON.parse(response.body)
        errors_json = { errors: [ status: 400, message: [{ email: "Not match password" }] ]}
        # expect(json_response).to eql errors_json
      end
    end
  end


end
