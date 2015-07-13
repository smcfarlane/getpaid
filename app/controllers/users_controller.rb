class UsersController < AuthorizeController
  before_filter :authenticate_account!
  before_action :authorize_admin, only: [:index_all]
  layout 'dashboard'

  def index_all
    @users = User.all.paginate(:page => params[:page], :per_page => 5)
  end

  def index
    @organization = current_account.user.organization
    @users = @organization.users.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @user = User.new
    @user.addresses.build
    @user.phones.build
    @user.emails.build
    @user.build_organization
  end

  def create
    @user = User.create(get_new_user_params)
    if @user.save
      redirect_to new_your_org_path
    end
  end

  def edit

  end

  def update

  end

  private

  def get_new_user_params
    results = params.require(:user).permit(:account_id, :first_name, :last_name, phones_attributes: [:phone_number], emails_attributes: [:email], addresses_attributes: [:street_address, :street_address2, :city, :state, :zip])
  end

end
