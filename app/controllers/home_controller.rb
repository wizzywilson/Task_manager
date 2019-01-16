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

  def project_user_task
    user_id = params[:project_user][:user_id]
    project_id = params[:project]
    @project_user = ProjectUser.where(user_id: user_id,project_id: project_id).first
    if @project_user.nil?
      @project_user = ProjectUser.new(user_id: user_id, project_id: project_id, assigned_by: current_user.id, designation: :DEV )
    end
    @project_user.tasks.build(task_params)
    @project_user.save
    project_details

    respond_to do |format|
      format.js {render action: 'project_details'}
    end

  end

  def project_details
    @project = Project.find(params[:project])
    pm = @project.project_users.PM.pluck(:user_id) # gives current projects PM
    @users = User.employee.where.not(id:pm)


    @role  = ProjectUser.where(user_id: current_user.id, project_id: @project.id).first.designation

    @projectuser = ProjectUser.new
    @projectuser.project_id = @project.id
    @task = Task.new

    if @project_user.nil?

    respond_to do |format|
      format.js
    end
  end
  end

  private

  def task_params
      params.require(:project_user).require(:task).permit(:name, :start_date,:end_date)
  end
end
