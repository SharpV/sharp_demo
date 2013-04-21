//= require jquery-fileupload

$(document).ready(function() {
  // Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload({
    maxFileSize: 5000000,
    limitMultiFileUploads: 10
  });
  // 
  // Load existing files:
  /*
  $.getJSON($('#fileupload').prop('action'), function (files) {
    var fu = $('#fileupload').data('fileupload'), template;
    fu._adjustMaxNumberOfFiles(-files.length);
    console.log(files);
    template = fu._renderDownload(files).appendTo($('#fileupload .files'));
    //template = $('#fileupload .files').prepend(fu._renderDownload(files));
    // Force ref  
    fu._reflow = fu._transition && template.length &&
      template[0].offsetWidth;
    template.addClass('in');
    $('#loading').remove();
  });
  */

  });