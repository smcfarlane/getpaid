class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :paid, :email_client]
  before_action :authenticate_account!
  layout 'dashboard'

  def index
    @invoices = current_account.user.organization.invoices.where(active: true)
  end

  def show
    redirect_to :back unless @invoice.active
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context)
        send_data pdf.render, filename: "invoice_#{@invoice.created_at.strftime("%d/%m/%Y")}.pdf",
                  type: 'application/pdf'
      end
    end
  end

  def new
    @invoice = Invoice.new
    if params[:project_id] && params[:org_id]
      @project = Project.find(params[:project_id])
      @organization = Organization.find(params[:org_id])
    end
  end

  def create
    @invoice = Invoice.create(get_invoice_params)
    if @invoice.save
      redirect_to organization_project_path(@invoice.to_org_id, @invoice.project_id)
    else
      render :edit
    end
  end

  def edit
  end

  def update
    @invoice.update(get_invoice_params)
    if @invoice.save
      redirect_to organization_project_path(@invoice.to_org_id, @invoice.project_id)
    else
      render :edit
    end
  end

  def destroy
    @invoice.active = false
    @invoice.save
    redirect_to :back
  end

  def paid
    @invoice.paid = true
    @invoice.save!
    redirect_to :back
  end

  def email_client
    InvoiceMailer.email_client(@invoice, current_user, params[:to], params[:from]).deliver
    redirect_to :back
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def get_invoice_params
    p = params.require(:invoice).permit(:project_id, :to_org_id, :identifier, :notes, date: [:day, :month, :year], due_date: [:day, :month, :year], line_items_attributes: [:id, :item, :amount, :description])
    {project_id:p[:project_id], to_org_id: p[:to_org_id], identifier: p[:identifier], notes: p[:notes], date: Date.new(p[:date][:year].to_i, p[:date][:month].to_i, p[:date][:day].to_i), due_date: Date.new(p[:due_date][:year].to_i, p[:due_date][:month].to_i, p[:due_date][:day].to_i), line_items_attributes: p[:line_items_attributes]}
  end
end
