data = [
  {
    'value': '1'
    'label': 'one'
  }
  {
    'value': '2'
    'label': 'two'
  }
  {
    'value': '3'
    'label': 'three'
  }
]
module.exports.autocomplete = $ ->
  $('input#txtKeyword').autocompleter
  source: data
  focusOpen: false
  return