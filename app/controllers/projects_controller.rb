class ProjectsController < ApplicationController
  before_filter :locate_project, :only => [:show, :build, :edit, :update]
  def index
    @projects = Project.order("created_at DESC")
  end

  def show
    @builds = @project.builds.order("created_at DESC").limit(@project.max_builds)
  end

  def build
    @project.build!
    redirect_to(project_path(@project))
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @project.update_attributes!(params[:project])
    redirect_to project_path(@project)
  end

  private
  def locate_project
    @project = Project.find(params[:id])
  end
end