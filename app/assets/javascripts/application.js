// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.flot
//= require jquery.flot.time
//= require jquery.flot.resize
//= require_tree .

$(function(){ $(document).foundation(); });

$(function(){

    var clearAlert = setTimeout(function(){
        $(".alert-box.success").fadeOut('slow')
    }, 1500);

    $(document).on("click", ".alert-box.success a.close", function(event){
        clearTimeout(clearAlert);
    });

    $(document).on("click", ".alert-box a.close", function(event) {
        event.preventDefault();
        $(this).closest(".alert-box").fadeOut(function(event){
            $(this).remove();
        });
    });

});
