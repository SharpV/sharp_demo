//= require jquery-fileupload

$(document).ready(function() {
  // Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload({
    maxFileSize: 5000000,
    limitMultiFileUploads: 10,
     acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
  });

  $('#image_album_id').change(function() {
    if($('#image_album_id').val() > 0){
      $('#upload_btn').show();
    }else{
      $('#upload_btn').hide();
    }
    $('#media-list').empty();
  });
});

//= jquery-file-upload-locale
