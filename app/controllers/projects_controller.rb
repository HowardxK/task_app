class ProjectsController < ApplicationController
  
  def index
  end
  
  def new
    @project = current_user.projects.new
  end
end
