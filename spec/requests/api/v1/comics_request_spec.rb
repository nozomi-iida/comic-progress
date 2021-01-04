require "rails_helper"

RSpec.describe "Api::V1::Comics", type: :request do
  it "Get comics" do
    get "/api/v1/comics"
    expect(response).to have_http_status(:ok)
  end
end
