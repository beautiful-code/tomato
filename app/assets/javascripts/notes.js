$(document).ready(function () {

    $('.notes-container').notesManager();


});


;
(function ($) {
    $.fn.extend({
        notesManager: function (options) {
            this.defaultOptions = {};

            var settings = $.extend({}, this.defaultOptions, options);

            return this.each(function () {
                var $this = $(this);


                $this.showNotes = function (data) {
                    $('.review-notes').html(data);
                };

                $this.removePopover = function (data) {
                    $('.desc').popover('destroy');
                };


                $this.find('.cancel-button').click(function (event) {
                    event.preventDefault();
                    $this.removePopover();
                });

                $this.find('.save-button').click(function (event) {
                    event.preventDefault();
                    var url = $this.find('.note-form').attr('action');

                    var data = {
                        'note[item]': $this.find('#note_item').val(),
                        'note[rating]': $('input[name="note[rating]"]:radio:checked').val()
                    };

                    $.ajax({
                        type: 'POST',
                        url: url,
                        data: data

                    }).done(function (data) {
                            $this.removePopover();

                            $this.showNotes(data);

                            //$this.clearForm();


                        }).fail(function () {
                            alert('Note creation failed.');
                        });
                });


            });
        }
    });
})(jQuery);




