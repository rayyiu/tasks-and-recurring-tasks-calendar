module TasksHelper
  def search_tasks_by_params
    query_params = {}
    query_params[:task_date] = @task_date_param
  end
end
