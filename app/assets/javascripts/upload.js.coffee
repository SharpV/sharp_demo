jackUp.on "upload:success", (e, options) ->
  $("img[data-id='#{options.file.__guid__}']").css(borderColor: "green")

  # read the response from the server
  medium = JSON.parse(options.responseText)
  mediumId = medium.id
  # create a hidden input containing the asset id of the uploaded file
  mediumElement = $("<input type='hidden' name='post[asset_ids][]'>").val(assetId)
  # append it to the form so saving the form associates the created post
  # with the uploaded assets
  $(".file-drop").parent("form").append(assetIdsElement)