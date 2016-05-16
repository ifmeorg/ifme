$(document).bind('page:before-unload', function() {
    if (typeof(CKEDITOR) != "undefined") {
        for (name in CKEDITOR.instances) {
            CKEDITOR.instances[name].destroy(true);
        }
    }
});