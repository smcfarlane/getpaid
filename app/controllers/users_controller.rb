class UsersController < AuthorizeController
  before_filter :authenticate_account!
  before_action :authorize_admin, only: [:index_all]
  before_action :get_user, only: [:edit, :update, :destroy, :make_manager]
  layout 'dashboard', except: [:edit]

  def index_all
    @users = User.all.paginate(:page => params[:page], :per_page => 5)
  end

  def index
    @organization = current_account.user.organization
    @users = @organization.users.paginate(:page => params[:page], :per_page => 20)
  end

  def make_manager
    @user.account.add_role :manager, @user.organization
    redirect_to :back
  end

  def new
    unless current_account.user
      @user = User.new
      @user.addresses.build
      @user.phones.build
      @user.emails.build
      @user.build_organization
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def create
    unless current_account.user
      @user = User.create(get_new_user_params)
      if @user.save
        redirect_to new_your_org_path
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def edit
  end

  def update
    @user.update(get_new_user_params)
    if @user.save
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :back
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def get_new_user_params
    results = params.require(:user).permit(:account_id, :first_name, :last_name, phones_attributes: [:id, :phone_number], emails_attributes: [:id, :email], addresses_attributes: [:id, :street_address, :street_address2, :city, :state, :zip])
  end

end
