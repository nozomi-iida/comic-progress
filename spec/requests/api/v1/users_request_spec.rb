require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe "GET /api/v1/users" do
    it "get all users" do
      users = create_list(:user, 10)
      token = encode_token({ user_id: users.first.id })
      get api_v1_users_path, headers: { "Authorization" => "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json["users"].length).to eq(10)
    end
  end

  describe "POST /api/v1/users" do
    it "create user" do
      user = attributes_for(:user)
      expect { post "/api/v1/users", params: { user: user } }.to change(User, :count).by(1)
      expect(response).to have_http_status(:ok)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

  describe "DELETE /api/v1/users" do
    it "delete user" do
      user = create(:user)
      expect { delete "/api/v1/users/#{user.id}" }.to change(User, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
