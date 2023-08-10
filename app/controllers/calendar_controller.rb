class CalendarController < ApplicationController
  respond_to? :json
  def index
    year = params[:year].to_i
    month = params[:month].to_i

    year ||= Date.today.year
    month ||= Date.today.month

    if year < 1900 || year > 2100 || month < 1 || month > 12
      render json: { error: "Invalid year (#{year}) or month" }, status: :unprocessable_entity
      return
    end

    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month
    @monthly_tasks = Task.where(task_date: start_date..end_date)
    render json: @monthly_tasks.to_json
  end
end
