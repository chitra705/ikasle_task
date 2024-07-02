class AddDurationToProjectTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :project_tasks, :duration, :float
  end
end
