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
    @project_user = ProjectUser.find_by(user_id: user_id, project_id: project_id)
    if @project_user.nil?
      @project_user = ProjectUser.new(user_id: user_id, project_id: project_id,
                                      assigned_by: current_user.id,
                                      designation: :DEV)
    end
    @project_user.tasks.build(task_params)
    @project_user.save!
    set_project_data
    respond_to do |format|
      format.js { render action: 'project_details'}
    end

  end

  def project_details
    set_project_data

    respond_to do |format|
      format.js
    end
  end

  private

  def set_project_data
    @project = Project.find(params[:project])
    @users = users_for_assigning_task
    @role = user_role

    @projectuser = ProjectUser.new
    @projectuser.project_id = @project.id
    @tasks = project_tasks
  end

  def project_tasks
    Task.joins(:project_user).where(project_users: { project_id: @project.id })
  end

  def users_for_assigning_task
    pm = @project.project_users.PM.pluck(:user_id) # gives current projects PM
    User.employee.where.not(id: pm)
  end

  def user_role
    ProjectUser.where(user_id: current_user.id, project_id: @project.id).first.designation
  end

  def task_params
    params.require(:project_user).require(:task).permit(:name, :start_date, :end_date, :status)
  end
end
