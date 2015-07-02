class InvoiceMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  def email_client invoice, current_user, from=nil, to=nil
    from ||= current_user.email
    to ||= invoice.to_org.emails[0].email
    @invoice = invoice
    @download = link_to 'Download', invoice_path(@invoice, format: 'pdf')
    mail to: to, from: from, subject: "Important: Invoice from #{current_user.user.organization.name}"
  end

end
