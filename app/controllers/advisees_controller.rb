class AdviseesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @advisees = Advisee.all
  end

  def show
    @advisee = Advisee.find(params[:id])
  end
end
