class Api::V1::TasksController < ApplicationController
  def index
    render json: Task.all
  end

  def create
    task = Task.new(create_params)

    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:task).permit(:title, :description, :due_date)
  end
end
