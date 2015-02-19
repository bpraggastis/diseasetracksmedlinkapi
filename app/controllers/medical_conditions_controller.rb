class MedicalConditionsController < ApplicationController
  respond_to :json

  def index
    redirect_to root_path
  end

  def show
    response = {}
    medical_condition = Event.find(params[:id]).medical_condition
    image_url = medical_condition.codes.find_by(code_system: "image")[:code_value]
    response["image"] = image_url
    response["medical_condition"] = medical_condition
    respond_with response
  end

end
