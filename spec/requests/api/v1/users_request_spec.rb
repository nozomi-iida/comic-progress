require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /api/v1/users" do
    it "get all users" do
      create_list(:user, 10)
      get "/api/v1/users"
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json["users"].length).to eq(10)
    end
  end

  describe "POST /api/v1/users" do
    it "create user" do
      valid_params = {
        first_name: "Nozomi",
        last_name: "Iida",
        email: "test@test.com",
      }
      expect { post "/api/v1/users", params: { user: valid_params } }.to change(User, :count)
      expect(response).to have_http_status(:created)
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