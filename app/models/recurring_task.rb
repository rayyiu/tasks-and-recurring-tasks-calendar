class RecurringTask < Task
  default_scope { Task.unscoped.where(type_of_task: 'RecurringTask') }

  enum recurrence_rate: {
    daily: 0,
    every_weekday: 1,
    every_other_day: 2,
    weekly: 3,
    every_other_week: 4,
    monthly: 5,
    annually: 6,
    custom: 7
  }

  enum custom_recur_frequency_interval: {
    # hours: 0,                   Not currently implemented
    days: 1,
    weeks: 2,
    months: 3,
    years: 4
  }

  validates :title, :recurrence_rate, :recurrence_start_date, presence: true
  validates :custom_recur_frequency_number,
            numericality: { greater_than: 0 },
            if: lambda { |o|
                  o.custom_recur_frequency_interval.present?
                }

  def custom_weekly_recurrence?
    recurrence_rate == 'custom' && custom_recur_frequency_interval == 'weekly'
  end

  def custom_hourly_recurrence?
    recurrence_rate == 'custom' && custom_recur_frequency_interval == 'hours'
  end

  def get_custom_hourly_recurrences(date)
    get_ice_cube_schedule.occurrences_between(date, date + 1, spans: true)
  end

  def recurrence_description
    get_ice_cube_schedule.to_s
  end

  def calculate_recurrence_dates_based_on_date(date)
    get_ice_cube_schedule.occurs_on?(date)
  end

  def get_ice_cube_schedule
    task_recurrence_schedule = IceCube::Schedule.new(recurrence_start_date)

    case recurrence_rate
    when 'daily'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.daily.until(recurrence_end_date))
    when 'every_weekday'
      task_recurrence_schedule
        .add_recurrence_rule(IceCube::Rule.weekly(1)
        .day(1, 2, 3, 4, 5).until(recurrence_end_date))
    when 'every_other_day'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.daily(2).until(recurrence_end_date))
    when 'weekly'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.weekly)
    when 'every_other_week'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.weekly(2).until(recurrence_end_date))
    when 'monthly'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.monthly.until(recurrence_end_date)) # if it's the 15th of August, is it the 15th of September then?
    when 'annually'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.yearly.until(recurrence_end_date)) # check until as exclusive or inclusive.
    when 'custom'
      task_recurrence_schedule = calculate_custom_recurrence_date
    end

    task_recurrence_schedule
  end

  private

  def calculate_custom_recurrence_date
    task_recurrence_schedule = IceCube::Schedule.new(recurrence_start_date)
    custom_number = custom_recur_frequency_number
    case custom_recur_frequency_interval
    when 'days'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.daily(custom_number).until(recurrence_end_date))
    when 'weeks'
      # ice_cube takes dates in the format (1, 2, 3) as well
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.weekly(custom_number).day(repeat_on).until(recurrence_end_date))
    when 'months'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.monthly(custom_number).until(recurrence_end_date))
    when 'years'
      task_recurrence_schedule.add_recurrence_rule(IceCube::Rule.yearly(custom_number).until(recurrence_end_date))
    end
    task_recurrence_schedule
  end
end
