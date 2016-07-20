class AdviseesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @advisees = Advisee.all_for(current_user)
  end

  def show
    @advisee = Advisee.find(params[:id])
  end

  def new
    @advisee = Advisee.new
    @semesters = Semesters.all_for_select
  end

  def create
    @advisee = Advisee.new(advisee_params)

    if @advisee.save
      flash[:success] = 'Advisee added successfully'
      redirect_to advisee_path(@advisee)
    else
      flash[:alert] = 'There was a problem creating that advisee'
      @errors = @advisee.errors.full_messages
      @semesters = Semesters.all_for_select

      render 'advisees/new'
    end
  end

  def destroy
    Advisee.destroy(params[:id])
    flash[:success] = 'Advisee deleted successfully!'

    redirect_to advisees_path
  end

  private

  def advisee_params
    params.require(:advisee).permit(:first_name,
                                    :last_name,
                                    :email,
                                    :graduation_semester,
                                    :graduation_year)
  end
end
