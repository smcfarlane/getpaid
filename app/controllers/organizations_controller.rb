class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update]
  before_filter :authenticate_account!
  layout 'dashboard'

  # GET /organizations
  def index
    @organization = current_account.user.organization
  end

  # GET /organizations/1
  def show
    get_kind @organization
  end

  def new_client
    @kind = 'client'
    @organization = Organization.new
  end

  def new_vendor
    @kind = 'vendor'
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
    @kind = get_kind @organization
  end

  # POST /organizations
  def create
    @organization = Organization.create(org_params)
    current_account.user.organization.vendors << @organization if params[:partner_type] == 'vendor'
    current_account.user.organization.clients << @organization if params[:partner_type] == 'client'
    @address = Address.create(address_params)
    @address.update_attribute :addressable, @organization
    @phone = Phone.create(phone_params)
    @phone.update_attribute :callable, @organization

    if @organization.save && @address.save && @phone.save
      redirect_to organizations_path
    else
      @kind = params[:partner_type]
      render :edit
    end
  end

  # PATCH/PUT /organizations/1
  def update
    @organization = Organization.update(org_params)
    current_account.user.organization.vendors << @organization if params[:partner_type] == 'vendor'
    current_account.user.organization.clients << @organization if params[:partner_type] == 'client'
    @organization.addresses[0].update(address_params)
    @organization.phones[0].update(phone_params)

    if @organization.save
      redirect_to organizations_path
    else
      @kind = params[:partner_type]
      render :edit
    end
  end

  # DELETE /organizations/1
  def destroy_client
    @partner = Partner.where(organization_id: current_account.user.organization, client_id: params[:id])
    @partner.each {|partner| partner.destroy}
    redirect_to organizations_path
  end

  def destroy_vendor
    @partner = Partner.where(organization_id: current_account.user.organization, vendor_id: params[:id])
    @partner.each {|partner| partner.destroy}
    redirect_to organizations_path
  end

  def add_to_project
    if params[:kind] == 'client'
      @organization = Organization.find(params[:id])
      @organization.projects << Project.find(params[:project_id])
    elsif params[:kind] == 'vendor'
      @organization = Organization.find(params[:id])
      @organization.projects << Project.find(params[:project_id])
    end
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def get_kind o
      if o.vendor_clients.include? current_account.user.organization
        @kind = 'vendor'
      end
      if o.managers.include? current_account.user.organization
        if @kind
          @kind = 'client and vendor'
        else
          @kind = 'client'
        end
      end
    end

    def org_params
      params.require(:org).permit(:name)
    end

    def address_params
      params.require(:address).permit(:street_address, :street_address2, :city, :state, :zip)
    end

    def phone_params
      params.require(:phone).permit(:phone_number)
    end
end
