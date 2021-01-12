require "rails_helper"

RSpec.describe "Api::V1::Comics", type: :request do
  def set_header
    user = create(:user)
    token = encode_token({ user_id: user.id })
    return { "Authorization" => "Bearer #{token}" }
  end

  let(:comic) { create(:comic) }

  describe "GET /api/v1/comics" do
    it "should get all comics " do
      create_list(:comic, 10)
      get api_v1_comics_path, headers: set_header
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["comics"].length).to eq(10)
    end
  end

  describe "SHOW /api/v1/comics" do
    it "should show comic" do
      comic
      get api_v1_comics_path(comic.id), headers: set_header
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["comics"][0]["id"]).to eq comic.id
    end
  end

  describe "POST /api/v1/comics" do
    it "should create comic" do
      comic = attributes_for(:comic)
      expect { post "/api/v1/comics", params: { comic: comic }, headers: set_header }.to change(Comic, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /api/v1/comics" do
    it "should edit comic" do
      user = build(:user)
      comic
      if comic.user.id == user.id
        patch api_v1_comic_path(comic.id), params: { comic: { volume: 2 } }, headers: set_header
        expect(response).to have_http_status(:ok)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["comic"]["volume"]).to eq 2
      end
    end

    it "should not edit comic" do
      comic
      patch api_v1_comic_path(comic.id), params: { comic: { volume: 2 } }, headers: set_header
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["error"]).to eq "can't update comic"
    end
  end

  describe "DELETE /api/v1/comics" do
    it "should delete comic " do
      user = build(:user)
      comic
      if comic.user.id == user.id
        expect { delete "/api/v1/comics/#{comic.id}", headers: set_header }.to change(Comic, :count).by(-1)
        expect(response).to have_http_status(204)
      end
    end

    it "should not delete comic" do
      comic
      delete api_v1_comic_path(comic.id), params: { comic: { volume: 2 } }, headers: set_header
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["error"]).to eq "can't delete comic"
    end
  end
end
