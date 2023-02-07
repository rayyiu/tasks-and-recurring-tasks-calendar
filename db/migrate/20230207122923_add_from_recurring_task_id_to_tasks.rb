class AddFromRecurringTaskIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :from_recurring_tasks_id, :integer
  end
end
