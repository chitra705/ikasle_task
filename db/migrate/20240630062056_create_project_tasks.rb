class CreateProjectTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :project_tasks do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.integer :assigned_to
      t.float :duration

      t.timestamps
    end
  end
end