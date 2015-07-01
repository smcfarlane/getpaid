class InvoiceMailer < ApplicationMailer

  def email_client invoice, current_user, from=nil, to=nil
    from ||= current_user.email
    to ||= invoice.to_org.emails[0]
    @invoice = invoice
    @download = link_to 'Download', invoice_path(@invoice, format: 'pdf')
    Mail to: to, from: from, subject: "Important: Invoice from #{current_user.organization.name}"
  end

end
