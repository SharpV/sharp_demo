//= require jquery-fileupload

$(document).ready(function() {
  // Initialize the jQuery File Upload widget:
  $('#fileupload').fileupload({
    maxFileSize: 5000000,
    limitMultiFileUploads: 10
  });

  $('#medium_folder_id').change(function() {
    if($('#medium_folder_id').val() > 0){
      $('#upload_btn').show();
    }else{
      $('#upload_btn').hide();
    }
    $('#media-list').empty();
  });
});