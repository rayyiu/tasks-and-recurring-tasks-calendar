class Task < ApplicationRecord
  TASK_COLUMNS = %i[
    task_date
    is_completed
    task_description
    is_urgent
  ].freeze

  default_scope { order(created_at: :asc) }

  self.inheritance_column = 'is_task_recurring'

  validates :title, presence: true

  def recurring_task?
    is_task_recurring == 'RecurringTask'
  end
end
