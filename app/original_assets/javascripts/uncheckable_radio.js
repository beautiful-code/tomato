;(function( $ ){
  $.fn.uncheckable_radio = function() {
    return this.each(function() {
      $(this).mousedown(function() {
        $(this).data('wasChecked', this.checked);
      });

      $(this).click(function() {
        if($(this).data('wasChecked'))
          this.checked = false;
      });
    });
  };
})( jQuery );
