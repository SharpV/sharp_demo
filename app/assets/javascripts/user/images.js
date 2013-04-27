
//= require jquery-fileupload

$(document).ready(function() {
  // Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload({
    maxFileSize: 5000000,
    limitMultiFileUploads: 10,
     acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
  });
});

//= jquery-file-upload-locale
