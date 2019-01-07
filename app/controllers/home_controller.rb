class HomeController < ApplicationController
  def index
    if current_user.nil?
      redirect_to sign_in_path
    else
      authenticate_current_user!
    end
  end
end
