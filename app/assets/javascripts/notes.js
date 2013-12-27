/*$(document).ready(function () {


    $('body').on('submit', '.note-form', function (event) {
        //    alert('intercepted submit');
        event.preventDefault();
        var item = $('#note_item').val();
        var item_name = $('#note_item').attr('name');
        var rating = $('#note_rating').val();
        var rating_name = $('#note_rating').attr('name');
        var data = {}
        data[item_name] = item;
        data[rating_name] = rating;
        var container_id = $(this).closest('td').attr('id');

        var url = $('.note-form').attr('action');
        $.ajax({
            type: 'POST',
            url: url,
            data: data

        }).done(function (data) {

                $('#' + container_id).html(data);
                $('#' + container_id).find('.add-note').show();
                $('.note-form').hide();

            });


    });


    $('.note-form').hide();

    $('body').on("click", '.add-note', function (event) {
        console.log('fuck');
        $(this).closest('td').find('.note-form').show();
        $(this).hide();
    });


});*/


/*
$(document).ready(function () {

    var data = {}
    $('body').on('submit', '.note-form', function (event) {

        $(this).find('input').filter(function (e) {
            return (($(this).attr('type') != 'hidden') && ($(this).attr('type') != 'submit'))
        }).each
        (function (index, entry) {
            console.log($(entry).val());
            data[entry.name] = $(this).val();
        });
        var container_id = $(this).closest('td').attr('id');

        var url = $('.note-form').attr('action');
        $.ajax({
            type: 'POST',
            url: url,
            data: data

        }).done(function (data) {

                $('#' + container_id).html(data);
                $('#' + container_id).find('.add-note').show();
                $('.note-form').hide();

            });

    });


    $('body').on("click", '.add-note', function (event) {
        event.preventDefault();
        $(this).closest('td').find('.note-form').show();
        $(this).hide();
    });

    $('.notes-container').notesManager();

});

*/

$(document).ready(function () {

    $('.notes-container').notesManager();

});


;(function($){
    $.fn.extend({
        notesManager: function(options) {
            this.defaultOptions = {};

            var settings = $.extend({}, this.defaultOptions, options);

            return this.each(function() {
                var $this = $(this);

                $this.clearForm = function() {
                    $this.find('#note_item').val('');
                    $this.find('#note_rating').val('');
                };

                $this.hideForm = function() {
                    $this.find('.note-form').show();
                    $this.find('.add-note').hide();
                };

                $this.showAddButton = function() {
                    $this.find('.note-form').hide();
                    $this.find('.add-note').show();
                };

                $this.showNotes = function(data) {
                    $this.find('.review-notes').html(data);
                };



                $this.find('.add-note').click(function(event) {
                   event.preventDefault();
                   $this.hideForm();
                });

                $this.find('.cancel-button').click(function(event){
                    event.preventDefault();
                    $this.showAddButton();
                });

                $this.find('.save-button').click(function(event) {
                    event.preventDefault();

                    var url = $this.find('.note-form').attr('action');

                    var data = {
                      'note[item]':  $this.find('#note_item').val(),
                      'note[rating]': $this.find('#note_rating').val()
                    };

                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data

                    }).done(function (data) {
                        $this.showNotes(data);
                        $this.clearForm();
                        $this.hideForm();
                        $this.showAddButton();

                    }).fail(function() {
                      alert('Note creation failed.');
                    });
                });


            });
        }
    });
})(jQuery);




