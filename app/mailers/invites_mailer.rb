class InvitesMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def email_invite invite, user
    @user = user
    @invite = invite
    mail to: invite.email, from: 'getpaid@example.com', subject: "You have been invited to use Get Paid for invoices by #{user.first_name} #{user.last_name}"
  end
end
