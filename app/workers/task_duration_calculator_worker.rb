class TaskDurationCalculatorWorker
  include Sidekiq::Worker

  def perform(task_id)
    task = ProjectTask.find_by(id: task_id)
    return unless task
    duration_in_seconds = (task.updated_at - task.created_at).to_i
    task.update(duration_in_seconds: duration_in_seconds)
  end
end