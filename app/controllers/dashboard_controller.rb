class DashboardController < ApplicationController

  def index
    @tasks_created_per_day = ProjectTask.group(:created_at).count
    @task_status_distribution = ProjectTask.group(:status).count
    # @average_completion_time_per_week = ProjectTask.where(status: 'completed').group(:created_at)
    @average_completion_time_per_week = ProjectTask.where(status: 'completed').group(:created_at).select('created_at, COUNT(*) as task_count')
    @tasks_assigned_to_members = ProjectTask.group(:assigned_to).count
  end
end
