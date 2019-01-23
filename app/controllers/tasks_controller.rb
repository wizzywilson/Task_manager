class TasksController < ApplicationController
  protect_from_forgery
  def create

  end

  def update
    debugger

    respond_to do |format|
      format.js { render json: { task: @task } }
    end
  end

  def show
    @task = Task.find(params[:id])
    @project_user = @task.project_user
    respond_to do |format|
      format.js { render json: { status:200, task: @task, project_user: @project_user } }
    end
  end
end
