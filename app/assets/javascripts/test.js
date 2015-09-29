// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).on('submit', '#form', function (e) {
  e.preventDefault();
  $.post(e.target.action, $(e.target).serialize()).then(function (data, status) {
    $('.insert').prepend(data);
    $('.text_block').fadeIn(1000).removeClass('hide');
    e.target.reset();
  });
});
