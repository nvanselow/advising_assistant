class GraduationPlansController < ApplicationController
  def index
    @advisee = Advisee.find(params[:advisee_id])
    @graduation_plans = @advisee.graduation_plans
  end
end
