class Api::V1::SemestersController < ApiController
  before_filter :authenticate_user!
  before_filter do
    check_permissions(GraduationPlan.find(params[:graduation_plan_id]).advisee)
  end

  def index
    graduation_plan = GraduationPlan.find(params[:graduation_plan_id])
    semesters = graduation_plan.semesters
    render json: { semesters: semesters }, status: :ok
  end
end
