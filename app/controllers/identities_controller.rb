class IdentitiesController < ApplicationController
  def create
    identify = Identity.find_or_create_from_omniauth(request.env['omniauth.auth'],
                                                     current_user)

    redirect_to advisees_path
  end

  def destroy
  end
end
