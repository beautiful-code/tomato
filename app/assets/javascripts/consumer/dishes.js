$(document).ready(function () {

    $('.dish-row').click(function (e) {
        // Setting timeout to allow bootstrap to set active class
        $('#dishes_list').find('tr').each(function(){
           $(this).removeClass('active');
        });
        $this = $(this);
        setTimeout(function(){
            $this.addClass('active');
            $('#dishes_list').find('.dish-row').filter(
                function () {
                    return $(this).attr('class') == 'dish-row active'
                }).each(function(){
                    dish = $(this).attr('id');
                });
            $.cookie('dish', dish);
            console.log('Dish is'+ dish);
            e.preventDefault();
            drawChart();
            $('.dish-title').text(dish);

        },1);
    });




} );