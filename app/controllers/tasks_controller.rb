# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show]

  def index
    @tasks = Task.all
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
