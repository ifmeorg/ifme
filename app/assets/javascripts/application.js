// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require load_page.js
//= require js.cookie.js
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-readyselector
//= require underscore
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require_tree .

I18n.locale = Cookies.get("locale") || I18n.defaultLocale;

function isShow(forms) {
  var result = false;
  _.each(forms, function(form) {
    if ($("body").hasClass(form + " show")) {
      result = true;
      return;
    }
  });

  return result;
}

var onReadyApplication = function() {
  $.ajaxSetup({
    headers: {
      "X-CSRF-Token": $("meta[name='csrf-token']").attr("content")
    }
  });
};

loadPage(onReadyApplication);

var beforeunloadApplication = function() {
  $(window).scrollTop(0);
};

$(window).on("beforeunload", beforeunloadApplication);
