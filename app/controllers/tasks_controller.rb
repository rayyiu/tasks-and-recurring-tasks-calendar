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

  private

  def task_params 
    params.require(:task).permit(:title, :task_description, :task_date, :is_urgent)
  end
end
