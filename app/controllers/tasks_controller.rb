class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  # GET projects/1/tasks/1
  def index
    @tasks = @project.tasks
  end

  # GET projects/1/tasks/1
  def show
  end

  # GET projects/1/tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET projects/1/tasks/1/edit
  def edit
  end

  # POST projects/1/tasks
  def create
    @task =  @project.tasks.new(task_params)

    if @task.save
      redirect_to project_tasks_path(@task.project), notice: '任務已新增' 
    else
      render :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to(@task.project)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy

    redirect_to project_tasks_path(@task.project)
  end

  private

  def find_project
    @project = current_user.projects.find_by(id: params[:project_id])
  end

  def find_task
    @task = @project.tasks.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :project_id)
  end
end
