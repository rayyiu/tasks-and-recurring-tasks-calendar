module TasksHelper
  def search_tasks_by_params
    # non_recurring_tasks filtering
    query_params = {}
    query_params[:task_date] = @task_date_param
    non_recurring_tasks = Task.where(query_params)

    # Recurring Tasks filtering unimplemented
    recurring_query_params = {}
    selected_recurring_tasks = RecurringTask.where(recurring_query_params)

    # date filter for recurring tasks
    recurring_tasks = selected_recurring_tasks.map do |recurring_task|
      if recurring_tasks.calculate_recurrence_dates_based_on_date(Date.parse(@task_date_param))
        recurring_task
      end
    end

    #combining ids
    task_ids = (
      non_recurring_tasks.pluck(:id) +
      recurring_tasks.compact.pluck(:id)
    ).uniq - completed_recurring_task_ids

    @tasks = Task.where(id: task_ids)
  end
end