require 'rails_helper'

describe Api::V1::UsersController do

  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.build :user
      get :index
    end

    # it "returns the list users" do
      # user_response = JSON.parse(response.body)
      # binding.pry
      # expect(user_response['user'].except('birthday')).to eql @user.attributes.except(
      #   'blocked', 'created_at', 'updated_at', 'password_digest',
      #   'email_confirmed', 'confirm_token', 'birthday')
    # end

    it { expect(response.status).to eql 200 }

  end

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id
    end

    it "returns the information personal" do
      user_response = JSON.parse(response.body)
      expect(user_response['user'].except('birthday')).to eql @user.attributes.except(
        'blocked', 'created_at', 'updated_at', 'password_digest',
        'email_confirmed', 'confirm_token', 'birthday')
    end

    it { expect(response.status).to eql 200 }

  end

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.attributes_for :user
      @user =  @user.slice(:username, :email, :password, :password_confirmation)
      post :create, { user: @user }
    end

    context "when user is successfully created" do
      it "returns the information personal" do
        user_response = JSON.parse(response.body)
      end
    end

  end

  # describe "POST #create" do

  #   context "when user is successfully created" do
  #     before(:each) do
  #       @user_attributes = FactoryGirl.attributes_for :user
  #       @user_attributes =  @user_attributes.slice(:username, :password, :password_confirmation)
  #       post :create, { user: @user_attributes }
  #     end
  #     it "renders the json representation for the user record just created" do
  #       user_response = json_response
  #       expect(user_response[:email]).to eql @user_attributes[:email]
  #     end

  #     it { should respond_with 200 }
  #   end

  #   context "when is not created" do
  #     before(:each) do
  #       @invalid_user_attributes = { password: "12345678", password_confirmation: "12345678" } #notice I'm not including the email
  #       post :create, { user: @invalid_user_attributes }
  #     end

  #     it "renders an errors json" do
  #       user_response = json_response
  #       expect(user_response).to have_key(:errors)
  #     end

  #     it "renders the json errors on whye the user could not be created" do
  #       user_response = json_response
  #       expect(user_response[:errors][:email]).to include "can't be blank"
  #     end

  #     it { should respond_with 422 }
  #   end
  # end

  # describe "PUT/PATCH #update" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #   end

  #   context "when is successfully updated" do
  #     before(:each) do
  #       patch :update, { id: @user.id, user: { email: "newmail@example.com" } }
  #     end

  #     it "renders the json representation for the updated user" do
  #       user_response = json_response
  #       expect(user_response[:email]).to eql "newmail@example.com"
  #     end

  #     it { should respond_with 200 }
  #   end

  #   context "when is not created" do
  #     before(:each) do
  #       patch :update, { id: @user.id, user: { email: "bademail.com" } }
  #     end

  #     it "renders an errors json" do
  #       user_response = json_response
  #       expect(user_response).to have_key(:errors)
  #     end

  #     it "renders the json errors on whye the user could not be created" do
  #       user_response = json_response
  #       expect(user_response[:errors][:email]).to include "is invalid"
  #     end

  #     it { should respond_with 422 }
  #   end
  # end

  # describe "DELETE #destroy" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #     delete :destroy, { id: @user.id }
  #   end

  #   it { should respond_with 204 }

  # end
end
