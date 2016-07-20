class Api::V1::SearchAdviseesController < ApiController
  before_filter :authenticate_user!
  
  def index
    advisees = Advisee.where(user: current_user).
               search(params[:search]).
               order(:last_name)

    render json: { advisees: advisees }, status: :ok
  end
end
