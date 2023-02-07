class Task < ApplicationRecord
  TASK_COLUMNS = %i[
    task_date
    is_completed
    task_description
    is_urgent
  ].freeze

  default_scope { order(created_at: :asc) }

  self.inheritance_column = 'type_of_task'

  validates :title, presence: true
  validate :validate_connection_with_recurring_task

  def recurring_task?
    type_of_task == 'RecurringTask'
  end

  def validate_connection_with_recurring_task
    return if type_of_task != 'RecurringTask'

    if from_recurring_tasks_id.present? && !RecurringTask.exists?(from_recurring_tasks_id)
      errors.add(:from_recurring_task_id, 'is invalid')
    end
  end
end
