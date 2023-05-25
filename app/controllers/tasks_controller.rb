class TasksController < ApplicationController
  include TasksHelper
  def index
    @tasks = if params[:task_date].present?
               Task.where(task_date: params[:task_date]).order(:task_date)
               #  else
               #    Task.order(:task_date)
             end
    # search_tasks_by_params
    # the date needs to persist based on either the Date.today or the date that the user previously inputted
    # in the date_field tag
    # @task_date = task_params[:task_date].present? ? Date.parse(task_params[:task_date]) : Date.today
    # @tasks = Task.where(task_date: @task_date)
    # puts @tasks
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
