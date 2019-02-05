# frozen_string_literal: true

# Home controller
class HomeController < ApplicationController
  before_action :authenticate_current_user!
  def index; end

  def user_edit
    respond_to do |format|
      format.js
    end
  end

  def my_tasks
    @projects = current_user.projects
    @tasks = {}

    @projects.each do |project|
      user_tasks = ProjectUser.get_project_user(current_user.id, project.id)
                              .tasks
      @tasks.merge!(project.name.to_sym => user_tasks) unless user_tasks.empty?
    end
  end

  def create_project_user_task
    user_id = params[:project_user][:user_id]
    project_id = params[:project]
    @project_user = ProjectUser.get_project_user(user_id, project_id) # scoped

    if @project_user.nil?
      @project_user = ProjectUser.new(user_id: user_id, project_id: project_id,
                                      assigned_by: current_user.id,
                                      designation: :DEV)
    end
    @project_user.tasks.build(task_params)
    send_create_response
  end

  def send_create_response
    if @project_user.save
      project_user = @project_user.as_json(
        include: { user: { only: :email }, assigner: { only: :email } },
        only: :designation
      )
      task = Task.last.as_json(only: %i[id name status end_date start_date])
      render json: { status: 200, task: task, project_user: project_user }
    else
      render json: { status: 400, error: @project_user.errors }
    end
  end

  def profile_picture
    current_user.profile_picture.purge
    redirect_to root_path
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
    @task = Task.new
  end

  def project_tasks
    Task.joins(:project_user).where(project_users: { project_id: @project.id })
  end

  def users_for_assigning_task
    pm = @project.project_users.PM.pluck(:user_id) # gives current projects PM
    User.employee.where.not(id: pm)
  end

  def user_role
    ProjectUser.get_project_user(current_user.id, @project.id).designation
  end

  def task_params
    params.require(:project_user).require(:task).permit(:name, :start_date,
                                                        :end_date, :status)
  end
end
