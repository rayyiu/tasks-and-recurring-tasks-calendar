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
    hours: 0,
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
end
