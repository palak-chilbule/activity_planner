require 'rails_helper'

RSpec.describe "Api::V1::ProgramDayActivities", type: :request do
  describe "PATCH /api/v1/program_day_activities/:id/complete" do
    let!(:program_day) { create(:program_day, day_number: 2) }

    context "when completing an activity on the correct or past day" do
      let!(:pda) do
        create(:program_day_activity,
               program_day: program_day,
               completed: false,
               program_start_date: Date.today - 2)
      end

      it "marks the ProgramDayActivity as completed" do
        patch "/api/v1/program_day_activities/#{pda.id}/complete"

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)

        expect(json["completed"]).to eq(true)
        expect(json["activity_id"]).to eq(pda.activity_id)
        expect(json["current_program_day"]).to eq(3)
        expect(json["activity_day"]).to eq(2)
        expect(json["completed_late"]).to eq(true)
        expect(json["message"]).to eq("Activity completed late. Today is day 3, this was for day 2.")
        expect(pda.reload.completed).to eq(true)
      end
    end

    context "when trying to complete a future activity" do
      let!(:pda_future) do
        create(:program_day_activity,
               program_day: create(:program_day, day_number: 5),
               completed: false,
               program_start_date: Date.today - 2)
      end

      it "does not allow completing future activity" do
        patch "/api/v1/program_day_activities/#{pda_future.id}/complete"

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json["success"]).to eq(false)
        expect(json["error"]).to eq("Cannot complete a future activity. Today is day 3, this activity is for day 5.")
        expect(pda_future.reload.completed).to eq(false)
      end
    end
  end
end
