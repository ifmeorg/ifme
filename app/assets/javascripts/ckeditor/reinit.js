$(document).bind('page:before-unload', function() {
    if (typeof(CKEDITOR) !== "undefined") {
        for (var i in CKEDITOR.instances) {
          if ({}.hasOwnProperty.call(CKEDITOR.instances, i)) {
            CKEDITOR.instances[i].destroy(true);
          }
        }
    }
});
