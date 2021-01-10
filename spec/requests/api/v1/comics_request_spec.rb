require "rails_helper"

RSpec.describe "Api::V1::Comics", type: :request do
  describe "GET /api/v1/comics" do
    it "should get all comics " do
      create_list(:comic, 10)
      get "/api/v1/comics"
      parsed_body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["comics"].length).to eq(10)
    end
  end

  describe "SHOW /api/v1/comics" do
    it "should show comic" do
      comic = create(:comic)
      get api_v1_comics_path(comic.id)
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["comics"][0]["id"]).to eq comic.id
    end
  end

  describe "POST /api/v1/comics" do
    it "should create comic" do
      user = create(:user)
      comic = attributes_for(:comic)
      expect { post "/api/v1/comics", params: { comic: comic } }.to change(Comic, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/v1/comics" do
    it "should edit comic" do
      comic = create(:comic)
      patch api_v1_comic_path(comic.id), params: { comic: { volume: 2 } }
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["comic"]["volume"]).to eq 2
    end
  end

  describe "DELETE /api/v1/comics" do
    it "should delete comic " do
      comic = create(:comic)
      expect { delete "/api/v1/comics/#{comic.id}" }.to change(Comic, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
