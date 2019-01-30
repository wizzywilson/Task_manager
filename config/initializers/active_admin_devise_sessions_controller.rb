# frozen_string_literal: true

# Only admin users will enter the admin page
class ActiveAdmin::Devise::SessionsController
  include ::ActiveAdmin::Devise::Controller
  def create
    user = User.find_by(email: params[:user][:email])
    if user&.role != 'admin'
      flash[:error] = 'Only admin users can login through this portal'
      redirect_to request.referrer
    else
      super
    end
  end
end
