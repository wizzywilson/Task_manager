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
    @role  = ProjectUser.where(user_id:current_user.id,project_id:@project.id).first.designation
    @task = Task.new

    pm = @project.project_users.PM.pluck(:user_id)# gives current projects PM
    @users = User.employee.where.not(id:pm)
    respond_to do |format|
      format.js
    end
  end
end
