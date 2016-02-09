



# Submit search term when enter is pressed
$('#txtKeyword').keyup (e) -> if e.keyCode == 13
  showLoader()
  window.location = '/entity-extraction/'+$('#txtKeyword').val()