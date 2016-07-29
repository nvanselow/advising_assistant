class AdviseesController < ApplicationController
  before_filter :authenticate_user!
  before_filter only: [:show, :edit, :update, :destroy] do
    check_permissions(Advisee.find(params[:id]))
  end

  def index
    @advisees = Advisee.all_for(current_user)
  end

  def show
    @advisee = Advisee.find(params[:id])
    @notes = @advisee.notes.order(updated_at: :desc)
  end

  def new
    @advisee = Advisee.new
    @semesters = Semesters.all_for_select
  end

  def create
    @advisee = Advisee.new(advisee_params)
    @advisee.user = current_user

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

  def edit
    @advisee = Advisee.find(params[:id])
    @semesters = Semesters.all_for_select
  end

  def update
    @advisee = Advisee.find(params[:id])

    if @advisee.update(advisee_params)
      flash[:success] = 'Advisee info updated!'
      redirect_to advisee_path(@advisee)
    else
      flash[:alert] = 'There were problems updating the advisee'
      @errors = @advisee.errors.full_messages
      @semesters = Semesters.all_for_select

      render 'advisees/edit'
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
                                    :graduation_year,
                                    :photo)
  end
end
