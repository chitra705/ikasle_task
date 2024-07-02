class ProjectTask < ApplicationRecord

  enum status:{
  	active: 0,
  	paused: 1,
  	completed: 2 
  }
  belongs_to :user, foreign_key: 'assigned_to', optional: true
  before_save :calculate_task_duration

  validates :title, presence: true
  validates :status, presence: true
  # validates :status, inclusion: { in: %w[Active Paused Completed] }

  def self.create_task(incoming_values)
    t = ProjectTask.new(incoming_values)
    t.title       = incoming_values['title']
    t.description = incoming_values['description']
    t.status      = incoming_values['status']
    t.user_id     = incoming_values['user_id']
    t.duration    = incoming_values['duration']

    t.save!
  end

  def self.update_task(user_id,incoming_values)
    t = ProjectTask.find_by(id:id)
    t.email = incoming_values("email")
    t.user_role = incoming_values("user_role")
    t.save!   
  end

  def delete_task(user_id)
    t = ProjectTask.find_by(id:user_id)
    t.delete()
  end

  def get_all
    ProjectTask.all
  end

  def self.average_completion_time_per_week
    completed_tasks = ProjectTask.where(status: 'completed')
    completed_tasks.group(:created_at)
  end

  private

  def calculate_duration
    if status_changed? && status == 'completed'
      self.duration = (updated_at - created_at) / 1.hour
    end
  end
end
