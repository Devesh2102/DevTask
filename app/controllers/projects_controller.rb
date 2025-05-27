class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_manager_or_admin!, except: %i[index show]

  def index
    @projects = current_user.projects
  end

  def show
    @tasks = @project.tasks.order(:due_date)
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects_created.build(project_params)

    if @project.save
      # Add current user as manager
      ProjectMembership.create!(project: @project, user: current_user, role: "manager")
      redirect_to @project, notice: "Project created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :deadline)
  end

  def authorize_manager_or_admin!
    unless current_user.admin? || current_user.manager?
      redirect_to projects_path, alert: "You are not authorized to manage projects."
    end
  end
end
