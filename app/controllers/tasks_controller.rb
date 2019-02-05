# frozen_string_literal: true

# TasksController
class TasksController < ApplicationController
  protect_from_forgery

  def update
    @task = Task.find(params[:id])
    @task.assign_attributes(task_params)
    user_id = params[:project_user][:user_id]

    if @task.project_user_id != user_id
      @project_user = ProjectUser.find_by(user_id: user_id,
                                          project_id: params['project'])
      if @project_user.nil?
        @project_user = ProjectUser.create(user_id: user_id,
                                           project_id: params[:project],
                                           assigned_by: current_user.id,
                                           designation: :DEV)
      end
      @task.project_user_id = @project_user.id
      @project_user = @project_user.as_json(
        include: { user: { only: :email }, assigner: { only: :email } },
        only: :designation
      )
    end
    return_update_reply && return
  end

  def show
    @task = Task.find(params[:id])
    @project_user = @task.project_user
    @comments = @task.comments
    respond_to do |format|
      format.json { render json: { status: 200, task: @task,
                    project_user: @project_user }
      }
      format.js
    end
  rescue
    render json: { status: 400, error: 'Task not found' }
  end

  def destroy
    Task.find(params[:id]).destroy
    render json: { status: 200, id: params[:id] }
  rescue
    render json: { status: 400, error: 'Task not found' }
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
