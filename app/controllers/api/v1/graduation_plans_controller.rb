class Api::V1::GraduationPlansController < ApiController
  before_filter :authenticate_user!
  before_filter only: [:update] do
    check_permissions(GraduationPlan.find(params[:id]).advisee)
  end

  def update
    graduation_plan = GraduationPlan.find(params[:id])
    graduation_plan.name = params[:graduation_plan][:name]

    if graduation_plan.save
      render json: {
        message: 'Plan name updated!',
        graduation_plan: graduation_plan
      }
    else
      errors = graduation_plan.errors.full_messages
      render json: {
        message: 'There was a problem updating the graduation plan name',
        errors: errors
      }, status: :bad_request
    end
  end
end
