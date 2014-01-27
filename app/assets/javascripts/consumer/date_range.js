 (function($) {
   $.fn.setDateCookie = function(start,end){
     start_date = start.split('-')
     end_date = end.split('-')

     $.cookie('start_day', start_date[2]);
     $.cookie('start_month', start_date[1]);
     $.cookie('start_year', start_date[0]);

     $.cookie('end_day', end_date[2]);
     $.cookie('end_month', end_date[1]);
     $.cookie('end_year', end_date[0].trim());
   }

   $.fn.resetDateCookie = function(){
     $.cookie('start_day', '');
     $.cookie('start_month', '');
     $.cookie('start_year', '');

     $.cookie('end_day', '');
     $.cookie('end_month', '');
     $.cookie('end_year', '');
   }
 }(jQuery)); 

