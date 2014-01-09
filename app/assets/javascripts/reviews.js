$(document).ready(function () {

    // Hacking popover to support callback
    var tmp = $.fn.popover.Constructor.prototype.show;
    $.fn.popover.Constructor.prototype.show = function () {
        tmp.call(this);
        if (this.options.callback) {
            this.options.callback();
        }
    };


    // Uncheckable radio boxes
    $('#parameters input[type="radio"]').uncheckable_radio();

    function getSelectionText() {
        var text = "";
        if (window.getSelection) {
            text = window.getSelection().toString();
        } else if (document.selection && document.selection.type != "Control") {
            text = document.selection.createRange().text;
        }

        if (text != '') {
            $('.desc').popover('destroy');
            $('.desc').popover({
                html: true,
                content: $('#new_note_form').html(),
                callback: function () {
                    $('.popover .new-note-form #note_item').val(text);
                    $('.new-note-form').notesManager();
                }
            });
        }
    }


    $(document.body).bind('mouseup', function () {
        getSelectionText();
    });

});
