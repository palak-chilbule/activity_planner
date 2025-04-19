require 'rails_helper'

RSpec.describe "Api::V1::ProgramDays", type: :request do
  describe "GET /api/v1/program_days" do
    let!(:user) { create(:user) }

    it "returns all program days" do
      create_list(:program_day, 2)

      get "/api/v1/program_days", params: { user_id: user.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end

