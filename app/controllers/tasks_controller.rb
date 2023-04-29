class TasksController < ApplicationController
  include TasksHelper
  def index
    search_tasks_by_params
    @tasks = Task.where(created_at: params[:task_date])
  end

  def show
    @tasks = Task.where(task_date: params[:task_date])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to action: 'index', status: 303
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index_search
    task_list_params[:task_date] = index_search_params[:task_date] || task_list_params[:task_date]
    respond_to do |format|
      format.html { redirect_to tasks_index_path }
    end
  end
  # so we need to grab the date_param and store it in a variable, and then select all the tasks that have that task_date

  # def task_params
  #   params.require(:task).permit(:title, :task_description, :task_date, :is_urgent)
  # end
end
