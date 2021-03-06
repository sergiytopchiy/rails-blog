// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require tinymce/preinit.js
//= require tinymce/tinymce.js
//= require_tree .


$(document).on('change', '#locale-select', function () {
  $.post('/locale', {lang: this.value}).then(function () {
    Turbolinks.visit(location.toString());
  });
});

$(document).ready(function(){
  $(".navbar-text").addClass("hide");
  $(".navbar-text").fadeIn(600).removeClass("hide");
});

$(document).on('click', '.comment .btn-danger', function (e) {
  e.preventDefault();
  $.ajax(e.target.href, {method: 'delete'}).then(function () {
    $(e.target).parents('.comment').slideUp('slow');
  });
});

$(document).on('click', '.article_body .btn-danger', function (e) {
  e.preventDefault();
  $.ajax(e.target.href, {method: 'delete'}).then(function () {
    $(e.target).parents('.article_body').slideUp('slow');
  });
});


// $(e.target).action - url adress to create new comment
//$(e.target).serialize() - keep data from the object
// function data is a sent data from server
$(document).on('submit', '#new_comment', function (e) {
  e.preventDefault(); //ignore href attribute of "a" tag
  $.post(e.target.action, $(e.target).serialize()).then(function (data) {
    var $comment = $(data).hide();
    $('.comments').append($comment);
    $comment.slideDown('slow');
    e.target.reset();
  });
});

$(document).on('page:change',function(){
  tinyMCE.remove();
  tinyMCE.init({
    plugins: 'image code media',
    selector: '.tinymce',
    language: document.getElementById('locale-select').value
  });
});

