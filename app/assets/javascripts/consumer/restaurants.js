$(document).ready(function () {
    //Set default chart parameters as soons as screen loads and fdraw the graph
    category = [$('.category-name').attr('data')];
    $.cookie('category', category);

    $('.rating-box').click(function (e) {
        chart_parameters = [];
        // Setting timeout to allow bootstrap to set active class
        setTimeout(function(){
            $('#chart_parameters').find('.rating-box').filter(
                function () {
                    return $(this).attr('class') == 'btn btn-small rating-box active'
                }).each(function(){
                    chart_parameters.push($(this).attr('id'));
                });
            $.cookie('chart_parameters', chart_parameters);
            e.preventDefault();
            drawChart();

        },1);
    })

    $("#chart_parameters input[type=checkbox]").click(function(e) {
      chart_parameters = [];
      $("#chart_parameters").find('.chart-params').filter( function(){ 
        return  $(this).is(":checked") 
      }).each(function(){
        chart_parameters.push($(this).attr('id'));
      });
      $.cookie('chart_parameters', chart_parameters);
      drawChart();
    });

    if($.cookie('chart_parameters'))
    {
        parameters = $.cookie('chart_parameters').split(',');
    }
    else
    {
        parameters = [];
    }

    for(i=0;i<parameters.length;i++){
      $('#chart_parameters').find('#'+parameters[i]).first().addClass("active");
    }
});


