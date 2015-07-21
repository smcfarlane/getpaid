class ClientsController < OrganizationsController

  def index
    organization = current_account.user.organization.clients
    if current_account.has_role? :manager, current_account.user.organization
      return render json: organization.to_a
    else
      projects = Project.with_role(:employee, current_account).pluck(:id)
      authorize_orgs = Project.where(owner_id: @organization, id: projects).joins(:project_orgs).pluck(:organization_id)
      return render json: (organization & authorize_orgs)
    end
  end

  def show
    render json: @organization
  end

end
