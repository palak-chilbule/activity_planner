class Api::V1::ActivitiesController < ApplicationController
  before_action :set_activity, only: [:update, :destroy]

  def index
    render json: Activity.all
  end

  def create
    activity = build_activity
    if save_activity(activity)
      render json: activity, status: :created
    else
      render json: activity.errors, status: :unprocessable_entity
    end
  end

  def update
    if @activity.update(activity_params)
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy
    render json: "record deleted successfully"
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :frequency)
  end

  def build_activity
    Activity.new(activity_params)
  end

  def save_activity(activity)
    activity.save
  end
end
