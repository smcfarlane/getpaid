require 'digest/sha2'
class InvitesController < ApplicationController
  def invite_vendor
    @invite = Invite.create(get_invite_params)
    if @invite.save
      InvitesMailer.email_vendor_invite(@invoice, current_account.user)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def invite_client
    @invite = Invite.create(get_invite_params)
    if @invite.save
      InvitesMailer.email_client_invite(@invoice, current_account.user)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def get_invite_params
    result = params.require(:invite).permit(:organization_id, :email)
    {organization_id: result[:organization_id],
     email: result[:email],
     identifier: Digest::SHA2.new(256).hexdigest("#{result[:organization_id]}--#{result[:email]}"),
     inviting_user: current_account.user}
  end
end
