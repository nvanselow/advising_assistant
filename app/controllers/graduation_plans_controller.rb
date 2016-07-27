class GraduationPlansController < ApplicationController
  def index
    @advisee = Advisee.find(params[:advisee_id])
    @graduation_plans = @advisee.graduation_plans
  end

  def show
    @graduation_plan = GraduationPlan.find(params[:id])
  end

  def new
    @advisee = Advisee.find(params[:advisee_id])
    @graduation_plan = GraduationPlan.new
  end

  def create
    @advisee = Advisee.find(params[:advisee_id])
    @graduation_plan = @advisee.graduation_plans.new(grad_plan_params)

    if @graduation_plan.save
      @graduation_plan.create_default_semesters

      flash[:success] = 'Graduation plan created!'
      redirect_to graduation_plan_path(@graduation_plan)
    else
      flash[:error] = 'There was a problem with that graduation plan'
      @errors = @graduation_plan.errors.full_messages
      render 'graduation_plans/new'
    end
  end

  private

  def grad_plan_params
    params.require(:graduation_plan).permit(:name)
  end
end
