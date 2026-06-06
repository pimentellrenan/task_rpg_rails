class ProjectsController < ApplicationController
  before_action :require_authentication
  before_action :set_project, only: %i[edit update destroy]

  def index
    @project = current_user.projects.new(color: Project::COLORS.sample)
    @projects = current_user.projects.order(:name)
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to projects_path
    else
      @projects = current_user.projects.order(:name)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @project.update!(project_params)
    redirect_to projects_path
  end

  def destroy
    @project.destroy!
    redirect_to projects_path
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :color)
  end
end
