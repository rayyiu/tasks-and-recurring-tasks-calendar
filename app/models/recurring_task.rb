class RecurringTask < Task 
    default_scope { ToDoList.unscoped.where(type_of_to_do_list: 'RecurringToDoList') }

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

      
end