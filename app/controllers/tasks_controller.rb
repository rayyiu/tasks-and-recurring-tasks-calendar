class TasksController < ApplicationController
  include TasksHelper
  def index
    @tasks = if params[:task_date].present?
               Task.where(task_date: params[:task_date]).order(:task_date)
             else
               Task.order(task_date: :desc)
             end
    # @tasks = (Task.where(task_date: params[:task_date]).order(:task_date) if params[:task_date].present?)
  end

  def show
    @tasks = Task.where(task_date: params[:task_date])
    redirect_to action: 'index'
  end

  def new
    @task = Task.new
  end

  def create
    puts params.inspect
    @task = Task.new(task_params)

    if @task.save
      redirect_to action: 'index', status: 303
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def index_search
    task_params[:task_date] = index_search_params[:task_date] || task_list_params[:task_date]
    respond_to do |format|
      format.html { redirect_to tasks_index_path }
    end
  end
  # so we need to grab the date_param and store it in a variable, and then select all the tasks that have that task_date

  def task_params
    params.require(:task).permit(:task_date, :title, :task_description)
  end

  def index_search_params; end
end
