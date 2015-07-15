require 'digest/sha2'
class InvitesController < ApplicationController
  def invite
    @invite = Invite.create(get_invite_params)
    if @invite.save
      @account = Account.create(email: @invite.email, password: @invite.identifier[0, 10])
      @user = User.create(first_name: @invite.first_name, last_name: @invite.last_name,
                          account: @account, organization: @invite.organization)
      InvitesMailer.email_invite(@invite, current_account.user).deliver_now
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def get_invite_params
    result = params.require(:invite).permit(:organization_id, :email, :kind, :first_name, :last_name)
    {organization_id: (result[:kind] == 'employee' ? current_account.user.organization.id : result[:organization_id]),
     email: result[:email],
     kind: result[:kind],
     first_name: result[:first_name],
     last_name: result[:last_name],
     identifier: Digest::SHA2.new(256).hexdigest("#{result[:organization_id]}--#{result[:email]}"),
     inviting_user: current_account.user}
  end
end
