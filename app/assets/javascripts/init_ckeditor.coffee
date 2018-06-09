var ready = function() {
    CKEDITOR.on('instanceReady', function (ev) { // code });
}

$(document).ready(ready)
$(document).on('page:load', ready)
