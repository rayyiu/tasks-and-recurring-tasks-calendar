class AddRecurrenceDatetoTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :type_of_to_do_list, :string
    add_column :tasks, :recurrence_rate, :integer
  end
end
