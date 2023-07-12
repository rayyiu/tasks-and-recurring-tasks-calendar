class TasksController < ApplicationController
  include TasksHelper
  def index
    @tasks = params[:task_date].present? ? Task.where(task_date: params[:task_date]).where.not(is_completed: true).order(:task_date) : Task.where.not(is_completed: true).order(task_date: :desc)
    @completed_tasks = Task.where(is_completed: true).order(task_date: :asc)
  end

  def show
    @tasks = Task.where(task_date: params[:task_date])
    redirect_to action: 'index'
  end

  def new
    @task = Task.new
  end

  def create
    @task = if task_params[:task_type_selection] == 'recurring'
              RecurringTask.new(formatted_task_params)
            elsif task_params[:task_type_selection] == 'one time'
              Task.new(formatted_task_params)
            end

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

  def mark_as_completed
    @task = Task.find(params[:id])
    @task.update(is_completed: true)
    flash[:success] = 'Task marked as complete'
    redirect_to tasks_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'Task was successfully deleted' }
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
    params.require(:task).permit(:task_date, :title, :task_description, :recurrence_rate, :is_urgent,
                                 :custom_recur_frequency_number,
                                 :custom_recur_frequency_interval,
                                 :repeat_on_0, :repeat_on_1, :repeat_on_2, :repeat_on_3, :repeat_on_4, :repeat_on_5, :repeat_on_6,
                                 :recurrence_start_date,
                                 :recurrence_end_date, :task_type_selection)
  end

  def formatted_task_params
    if task_params[:task_type_selection] == 'recurring'
      task_params.slice(*RecurringTask.column_names).merge(repeat_on: construct_repeat_on_column_content)
    else
      task_params.slice(*Task.column_names)
    end
  end

  def construct_repeat_on_column_content
    result_repeat_on_field = []
    repeat_on_fields = %i[
      repeat_on_0
      repeat_on_1
      repeat_on_2
      repeat_on_3
      repeat_on_4
      repeat_on_5
      repeat_on_6
    ]

    repeat_on_fields.each_with_index do |field_symbol, index|
      result_repeat_on_field << index if task_params[field_symbol] == 'true'
    end

    result_repeat_on_field
  end

  VALID_ACTIONS = %w[new edit]

  def action_valid?
    VALID_ACTIONS.include?(params[:action])
  end

  def index_search_params; end
end
