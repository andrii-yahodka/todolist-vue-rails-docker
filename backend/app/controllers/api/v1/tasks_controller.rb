class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  def index
    render json: Task.all
  end

  def create
    task = Task.new(save_params)

    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(save_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def save_params
    params.require(:task).permit(:title, :description, :due_date)
  end
end
