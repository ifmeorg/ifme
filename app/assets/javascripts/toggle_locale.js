function toggleLocale(locale, localStorageLocale) {
	$.ajax({
		url: "/toggle_locale",
		data: {
      locale: locale,
      local_storage_locale: localStorageLocale
    }
	}).done(function(data) {
    if (data.signed_in_reload) {
      window.localStorage.setItem("locale", locale);
      window.location.reload();
    } else if (data.signed_out_reload) {
      var href = window.location.href.split("?")[0];
      window.localStorage.setItem("locale", locale);
      window.location.replace(href + "?locale=" + locale);
    }
	});
}

var onReadyToggleLocale = function() {
  var localStorageLocale = window.localStorage.getItem("locale");
  toggleLocale($("#locale").val(), localStorageLocale);
	$("#locale").change(function() {
		if ($(this).val()) {
			toggleLocale($(this).val(), localStorageLocale);
		}
	});
}

$(document).on("page:load ready", onReadyToggleLocale);
