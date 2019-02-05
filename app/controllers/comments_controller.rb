class CommentsController < ApplicationController
  def create
    @comment = Comment.create(name: params[:comment][:name],
                              task_id: params[:comment][:task],
                              user_id: params[:comment][:user])
    @task_count = Task.find(params[:comment][:task]).comments.count
    if @comment.save
      render json: { status: 200, comment: @comment, task_count: @task_count }
    else
      render json: { status: 400, error: @comment.errors.messages }
    end

    Comment.create(name: params[:comment][:name], task_id: params[:comment][:task],
                   user_id: params[:comment][:user])
  end
end
