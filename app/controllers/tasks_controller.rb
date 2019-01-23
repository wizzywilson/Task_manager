class TasksController < ApplicationController
  protect_from_forgery
  def create

  end

  def update
    debugger
    @task = Task.find(params[:id])
    respond_to do |format|
      format.js { render json: { task: @task } }
    end
  end
end
