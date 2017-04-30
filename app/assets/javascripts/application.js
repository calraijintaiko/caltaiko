// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require foundation
//= require cocoon
//= require slick
//= require picker
//= require picker.date
//= require picker.time
//= require legacy
//= require jquery.maskedinput.min
//= require webcomponentsjs/webcomponents-lite.min
//= require_tree .
//
//= require turbolinks

Foundation.global.namespace = '';
$(document).on('turbolinks:load', function() {
  $(function(){ $(document).foundation(); });
});
