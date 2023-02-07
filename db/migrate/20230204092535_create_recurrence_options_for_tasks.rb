class CreateRecurrenceOptionsForTasks < ActiveRecord::Migration[6.1]
  def change
    change_table :tasks do |t|
      t.string :is_task_recurring
      t.boolean :is_urgent, default: false
      t.boolean :is_completed, default: false
      t.integer :custom_recur_frequency_number, :custom_recur_frequency_interval
      t.integer :repeat_on, default: [], array: true
      t.date :recurrence_start_date, :recurrence_end_date
    end
  end
end
