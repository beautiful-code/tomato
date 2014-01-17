$(document).ready(function () {

        //Set default chart parameters as soons as screen loads and fdraw the graph
        category = [$('.category-name').data('category')];
        $.cookie('category', category);



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
            console.log('chart_parameters are '+ chart_parameters);
            e.preventDefault();
            drawChart();

        },1);
    })

    if($.cookie('chart_parameters'))
    {
        parameters = $.cookie('chart_parameters').split(',');
    }
    else
    {
        parameters = [];
    }

 for(i=0;i<parameters.length;i++){
     console.log('adding active class')
     $('#reviews_score').find('#'+parameters[i]).first().addClass("active");
     }



})


