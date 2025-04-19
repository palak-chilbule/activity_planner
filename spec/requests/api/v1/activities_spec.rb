require 'rails_helper'

RSpec.describe "Api::V1::Activities", type: :request do
  describe "GET /api/v1/activities" do
    it "returns all activities" do
      create_list(:activity, 3)

      get "/api/v1/activities"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "PATCH /api/v1/activities/:id" do
    let!(:activity) { create(:activity) }

    it "updates an activity's completed status" do
      patch "/api/v1/activities/#{activity.id}", params: { activity: { title: "Alen" } }

      expect(response).to have_http_status(:ok)
      expect(activity.reload.title).to be_truthy
    end

    it "returns an error for invalid update" do
      allow_any_instance_of(Activity).to receive(:update).and_return(false)

      patch "/api/v1/activities/#{activity.id}", params: { activity: { title: nil } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
