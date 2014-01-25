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
    old_text = ''  //Assign empty string to refer old text for the first time
    function getSelectionText() {
        var text = "";
        if (window.getSelection) {
            text = window.getSelection().toString();
        } else if (document.selection && document.selection.type != "Control") {
            text = document.selection.createRange().text;
        }
        if (text != '') {
            // Storing present selected value in variable to prevent popover close on clicking radio buytton

            if (text.toString() != old_text.toString()) {
                $('.desc').popover('destroy');
            }
            old_text = text;
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
