class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, except: [:new_without_org, :get_client_projects]
  before_filter :authenticate_account!
  layout 'dashboard'

  def index
  end

  def show
    @clients = []
    @vendors = []
    @project.organizations.each do |org|
      @clients << org if current_account.user.organization.clients.include? org
      @vendors << org if current_account.user.organization.vendors.include? org
    end
  end

  def new_without_org
    @project = Project.new
    @organization = current_account.user.organization
    render :new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    @organization.projects << @project
    if params[:org]
      clients = Organization.find(params[:org][:clients].map {|s| s.to_i})
      vendors = Organization.find(params[:org][:vendors].map {|s| s.to_i})
      clients.each {|client| client.projects << @project}
      vendors.each {|vendor| vendor.projects << @project}
    else
      current_account.user.organization.projects << @project
    end
    redirect_to organization_projects_path(@organization)
  end

  def edit
  end

  def update
    @project.update(project_params)
    redirect_to organization_path(@organization)
  end

  def destroy
    @organization.projects.destroy @project
    current_account.user.organization.projects.destroy @project
    redirect_to organization_path(@organization)
  end

  def get_client_projects
    @organization = Organization.find(params[:client_id])
    if current_account.user.organization.clients.include? @organization
      render json: {projects: (current_account.user.organization.owned_projects.pluck(:id, :name, :identifier) & @organization.projects.pluck(:id, :name, :identifier))}
    else
      render json: {projects: 'error'}
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def project_params
    result = params.require(:project).permit(:name, :identifier, start_date: [:day, :month, :year], end_date: [:day, :month, :year])
    {name: result[:name], identifier: result[:identifier],
     start_date: Date.new(result[:start_date][:year].to_i, result[:start_date][:month].to_i, result[:start_date][:day].to_i),
     end_date: Date.new(result[:end_date][:year].to_i, result[:end_date][:month].to_i, result[:end_date][:day].to_i), owner_id: current_account.user.organization.id}
  end
end
