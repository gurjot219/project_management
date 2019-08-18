class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @team = Team.find(params[:team_id]) if params[:team_id].present?
    @project = @team.projects.build
  end

  def create
    @team = Team.find(params[:team_id]) if params[:team_id].present?
    @project = @team.projects.build(project_params)
    @project.user_id = current_user.id if current_user.present?
    if @project.save
      redirect_to team_path(@project.team)
    else
      render 'new'
    end
  end

  def edit
    debugger
    @team = Team.find(params[:team_id]) if params[:team_id].present?
    @project = Project.find(params[:id])
  end

  def update
    if @project.update(project_params)
      redirect_to team_path(@project.team)
    else
      render 'edit'
    end
  end

  def show
  end


def destroy
  @project.destroy
  redirect_to projects_path
end


  private
  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :title)
  end
end
