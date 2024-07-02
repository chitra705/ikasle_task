class TasksController < ApplicationController
	# before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :change_status]
  after_action :verify_authorized

  # def index
  #   render json:ProjectTask.all, status:200
  # end

  # def show
  #   # authorize @task
  # end

  # def create
  #   incoming_values = JSON.parse(request.body.read)
  #   render json:ProjectTask.create_task(incoming_values), status:200
  # end

  # # def update
  # #   user_id = params[:id]
  # #   incoming_values = JSON.parse(request.body.read)
  # #   render json:ProjectTask.update_task(user_id,incoming_values), status:200
  # # end

  # def delete
  #   task_id = params[:id]
  #   render json:ProjectTask.delete_task(task_id), status:200
  # end

  # private

  # def set_task
  #   @task = ProjectTask.find(params[:id])
  # end

  # def task_params
  #   params.require(:project_task).permit(:title, :description, :status, :assigned_to)
  # end


  before_action :authenticate_user!
  include Pundit

  # Example action
  def index
    @project_tasks = policy_scope(Task)
  end

  def show
    @project_task = Task.find(params[:id])
    authorize @project_task
  end

  def new
    @project_task = Task.new
    authorize @project_task
  end

  def create
    @project_task = Task.new(project_task_params)
    authorize @project_task
    if @project_task.save
      redirect_to @project_task
    else
      render :new
    end
  end

  def edit
    @project_task = Task.find(params[:id])
    authorize @project_task
  end

  def update
    @project_task = Task.find(params[:id])
    authorize @project_task
    if @project_task.update(project_task_params)
      redirect_to @project_task
    else
      render :edit
    end
  end

  def destroy
    @project_task = Task.find(params[:id])
    authorize @project_task
    @project_task.destroy
    redirect_to project_tasks_path
  end

  private

  def project_task_params
    params.require(:task).permit(:title, :description, :status, :assigned_to, :duration)
  end
end
