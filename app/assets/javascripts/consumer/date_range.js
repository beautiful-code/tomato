$(document).ready(function () {
  if($('.date-range').length) {
    $('.date-range .submit').click(function(e) {
      var start_day = $('#date_start_date_3i').val();
      var start_month = $('#date_start_date_2i').val();
      var start_year = $('#date_start_date_1i').val();

      var end_day = $('#date_end_date_3i').val();
      var end_month = $('#date_end_date_2i').val();
      var end_year = $('#date_end_date_1i').val();

      $.cookie('start_day', start_day);
      $.cookie('start_month', start_month);
      $.cookie('start_year', start_year);

      $.cookie('end_day', end_day);
      $.cookie('end_month', end_month);
      $.cookie('end_year', end_year);

      e.preventDefault();

      window.location.reload();
    });
  }
  
});
