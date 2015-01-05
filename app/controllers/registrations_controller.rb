# Registrations Controller
class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:alert] = 'Please contact the website manager to see about' \
                    ' creating an administrative account.'
    redirect_to root_path
  end

  def create
    flash[:alert] = 'Please contact the website manager to see about' \
                    ' creating an administrative account.'
    redirect_to root_path
  end
end
