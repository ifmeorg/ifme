# frozen_string_literal: true
#
class TodoItemsController < ApplicationController
  before_action :set_task

  def create
    @todo_item = @task.todo_items.create(todo_item_params)
    redirect_to @task
  end

  private

  def set_task
    @task = TodoList.find(params[:task_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
