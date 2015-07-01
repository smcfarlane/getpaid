// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function get_projects_for_client(client_id) {
  $.ajax({
    url: '/get-client-projects',
    method: 'GET',
    data: {client_id: client_id}
  }).success(function(data) {
    console.log(data);
    var options = data.projects.map(function(option) {
      return '<option value="' + option[0] + '">' + option[1] + '</option>';
    });
    console.log(options);
    $('#projects').empty().append(options.join(' '));
  }).fail(function(data) {
    console.log('get projects for client failed');
    console.log(data);
  })
}

function add_another_line_item() {
  $('.line-items-set').append(
    [
    '<div class="col-md-12">',
      '<div class="form-group col-md-2 line-item">',
        '<label for="item">Item</label><br/>',
        '<input type="text" id="item" name="invoice[line_items_attributes][][item]" class="form-control"/>',
      '</div>',
      '<div class="form-group col-md-2">',
        '<label for="amount">Amount</label><br/>',
        '<input type="text" id="amount" name="invoice[line_items_attributes][][amount]" class="form-control"/>',
      '</div>',
      '<div class="form-group col-md-7">',
        '<label for="description">Description</label><br/>',
        '<input type="text" id="description" name="invoice[line_items_attributes][][description]" class="form-control"/>',
      '</div>',
      '<div class="col-md-1">',
        '<span class="glyphicon glyphicon-remove-circle"id="remove-item"  style="font-size: 24px;margin-top: 22px"></span>',
      '</div>',
    '</div>'
    ].join(' ')
  )
}

$(document).ready(function() {
  if (location.pathname === '/invoices/new') {
    get_projects_for_client($('.client_id').val());
    $('.client_id').change(function(){
      get_projects_for_client($('.client_id').val());
    });
    $('#new-item').click(function() {
      add_another_line_item()
    });
    $('.line-items-set').click(function(e) {
      console.log($(e.target));
      if ($(e.target).attr('id') === 'remove-item'){
        $(e.target).parent().parent().remove()
      }
    })
  }
});