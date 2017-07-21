$(document).on('turbolinks:load', function() {
  
  $('#journeyDate').datepicker({
     format: "dd/mm/yyyy"
  });

  $('#departureTime').timepicker({ 
    'forceRoundTime': true,
    'step': 5,
    'scrollDefault': 'now'
  });

});