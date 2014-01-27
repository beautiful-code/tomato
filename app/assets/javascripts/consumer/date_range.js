$(document).ready(function () {
   $('.range_inputs .applyBtn').click(function(e) {
      range = $('input[name="daterange"]').val().split(/\s-/)
      start_date = range[0].split('-')
      end_date = range[1].split('-')

      $.cookie('start_day', start_date[2]);
      $.cookie('start_month', start_date[1]);
      $.cookie('start_year', start_date[0]);

      $.cookie('end_day', end_date[2]);
      $.cookie('end_month', end_date[1]);
      $.cookie('end_year', end_date[0]);

      e.preventDefault();
      drawChart();
   });
});
