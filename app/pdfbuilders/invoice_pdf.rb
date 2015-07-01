class InvoicePdf < Prawn::Document

  def initialize(invoice, view)
    super()
    @invoice = invoice
    @view = view
    font 'Helvetica'
    from_and_to
    draw_invoice
    draw_details
    item_table
    notes
    total
  end

  def from_and_to
    text_box "From:
         #{@invoice.project.owner.name}", at: [10, 700], size: 16, font_style: :bold
    a = @invoice.project.owner.addresses[0]
    from = "#{a.street_address}, #{a.street_address2}
           #{a.city}, #{a.state} #{a.zip}
           #{@invoice.project.owner.phones[0].phone_number}"
    text_box from, at: [10, 660]

    text_box "To:
         #{@invoice.to_org.name}", at: [10, 600], size: 16, font_style: :bold
    a = @invoice.to_org.addresses[0]
    to = "#{a.street_address}, #{a.street_address2}
         #{a.city}, #{a.state} #{a.zip}
         #{@invoice.to_org.phones[0].phone_number}"
    text_box to, at: [10, 560]
  end

  def draw_invoice
    text_box "Invoice", at: [400, 700], size: 42, font_style: :bold
  end

  def draw_details
    dates = "Invoice #   : #{@invoice.identifier}
            Invoice Date : #{@invoice.date.strftime('%D')},
            Due Date     : #{@invoice.due_date.strftime('%D')}"
    text_box dates, at: [370, 560]
  end

  def item_table
    table = [['Item', 'Description', 'Amount']]
    @invoice.line_items.each do |item|
      table << [item.item, item.description, "$#{item.amount}"]
    end
    bounding_box([10, 475], width: 500) do
      table table, width: 500, header: true, column_widths: [150, 275, 75]
    end
  end

  def notes
    bounding_box([10, cursor - 30], width: 300) do
      text 'Notes:', size: 18, font_style: :bold
      text @invoice.notes
    end
  end

  def total
    text_box "<b>Total Amount:</b> $#{@invoice.line_items.sum(:amount)}", at: [400, cursor + 20], inline_format: true
  end
end