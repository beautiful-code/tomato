$(document).ready(function () {


    $('.rating-box').click(function (e) {
         chart_parameters = [];

        // Setting timeout to allow bootstrap to set active class
        setTimeout(function(){
            $('#reviews_score').find('.rating-box').filter(
                function () {
                    return $(this).attr('class') == 'btn rating-box active'
                }).each(function(){
                    chart_parameters.push($(this).attr('id'));
                });
            $.cookie('chart_parameters', chart_parameters);
            e.preventDefault();
            drawChart();

        },1);
    })


    parameters = $.cookie('chart_parameters').split(',');

 for(i=0;i<parameters.length;i++){
     $('#reviews_score').find('#'+parameters[i]).first().addClass("active");
     }



})


