// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $("tr[data-link]").click(function() {
    console.log($(this).attr("data-link"));
    window.location = $(this).attr("data-link");
  });
});