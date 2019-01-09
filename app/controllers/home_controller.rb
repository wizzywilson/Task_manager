class HomeController < ApplicationController

  def index
    if current_user.nil?
      redirect_to sign_in_path
    else
      authenticate_current_user!
    end
  end

  def user_edit
    respond_to do |format|
      format.js
    end
  end

  def project_details
    @project = Project.find(params[:project])
    respond_to do |format|
      format.js
    end
  end
end
