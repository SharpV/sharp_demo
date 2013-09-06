// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require lazybox
//= require rails.validations
//= require rails.validations.simple_form
//= bootstrap-dropdown
//= require rails-timeago
//= require locales/jquery.timeago.zh-CN.js
//= require scrollTo-min
//= require_self 

$(document).ready(function() {
  $('.images a').lazybox({closeImg: true});
});

$.lazybox.settings = {cancelClass: "button gray", submitClass: 'button gray', opacity: 0.5};

$('.dropdown-toggle').dropdown();

$('.tooltips').scojs_tooltip({
  content: "Tooltip content",
  cssclass: 'pretty',
  delay: 1000
});




