
window.drawDonuts = (comparisonData) ->
  for result, index in comparisonData
    chart = c3.generate(
      bindto: '#chart-'+index
      data:
        columns: [
            ['Positive', result.pieChart.positive ]
  #          ['Neutral', result.pieChart.neutral ]
            ['Negative',  result.pieChart.negative ]
        ]
        type: 'donut'
        colors: {
          Positive: '#01DF01',
          Neutral: '#848484',
          Negative: '#DF0101'
        }
      donut: title: result.searchTerm)


$('#get-results').click () ->
  url = '/comparer/'
  if $('#brand-1').val() != '' then url += $('#brand-1').val()
  if $('#brand-2').val() != '' then url += ','+$('#brand-2').val()
  if $('#brand-3').val() != '' then url += ','+$('#brand-3').val()
  if $('#brand-4').val() != '' then url += ','+$('#brand-4').val()
  showLoader()
  window.location = url

$('a#add-new').click () ->
  $('.input-field').slideDown('fast')
  $(this).fadeOut('fast')

$('#brand-2').keyup () ->
  if $(this).val() != ''
    $('.input-field').slideDown('fast')
    $('a#add-new').fadeOut('fast')