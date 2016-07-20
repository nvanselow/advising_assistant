class Api::V1::SearchAdviseesController < ApiController
  def index
    advisees = Advisee.search(params[:search])

    render json: { advisees: advisees }, status: :ok
  end
end
