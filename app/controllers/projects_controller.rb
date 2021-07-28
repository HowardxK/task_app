class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  
  def index
    @projects = current_user.projects
  end

  def show
  end
  
  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to projects_path, notice: '專案已新增'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: '專案已更新'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: '專案已刪除'
  end

  private
  
  def project_params
    params.require(:project).permit(:name, :description)
  end

  def find_project
    @project = current_user.projects.find_by(id: params[:id])
  end
end
