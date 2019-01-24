class TasksController < ApplicationController
  protect_from_forgery

  def update
    @task = Task.find(params[:id])
    @task.assign_attributes(task_params)

    user_id = params[:project_user][:user_id]

    if @task.project_user_id != user_id
       @project_user = ProjectUser.find_by(user_id: user_id, project_id: params['project'])
      if @project_user.nil?
        @project_user = ProjectUser.new(user_id: user_id, project_id: params[:project],
                                        assigned_by: current_user.id,
                                        designation: :DEV)
        @project_user.save
      end
      @task.project_user_id = @project_user.id
      @project_user = @project_user.as_json(include: { user:{only: :email }, assigner:{ only: :email }}, only: :designation )
    end
    return_update_reply and return
  end

  def show
    @task = Task.find(params[:id])
    @project_user = @task.project_user
    respond_to do |format|
      format.js { render json: { status: 200,
                                 task: @task,
                                 project_user: @project_user } }
    end
  end

  private

  def return_update_reply
    if @task.save
      render json: { status: 200, task: @task, project_user: @project_user }
    else
      render json: { status: 400, error: @task.errors.messages }
    end
  end

  def task_params
    params.require(:project_user).require(:task).permit(:name, :status,
                                                        :start_date, :end_date)
  end
end
