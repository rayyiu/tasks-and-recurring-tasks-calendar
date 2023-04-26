class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
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
    to_do_list_params[:to_do_date] = index_search_params[:to_do_date] || to_do_list_params[:to_do_date]
  end
  # so we need to grab the date_param and store it in a variable, and then select all the tasks that have that to_do_date

  private

  def task_params
    params.require(:task).permit(:title, :task_description, :task_date, :is_urgent)
  end
end
