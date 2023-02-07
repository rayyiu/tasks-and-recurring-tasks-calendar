class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :task_date
      t.text :task_description
      t.timestamps
    end
  end
end
