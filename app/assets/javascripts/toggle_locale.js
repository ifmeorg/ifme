function whenSignedOut(locale, previousLocale) {
  if (locale !== previousLocale) {
    window.document.cookie = `locale=${locale}`;
    window.location.reload();
  }
}

function toggleLocale(locale, previousLocale) {
  $.ajax({
    url: '/toggle_locale',
    data: {
      locale,
    },
  }).done((data) => {
    if (data.signed_in_no_reload) {
      Cookies.set('locale', data.signed_in_no_reload);
    } else if (data.signed_in_reload) {
      Cookies.set('locale', data.signed_in_reload);
      window.location.reload();
    } else {
      whenSignedOut(locale, previousLocale);
    }
  });
}

onReadyToggleLocale = function () {
  $('#locale').change(function () {
    if ($(this).val()) {
      const previousLocale = Cookies.get('locale');
      const updatedLocale = $(this).val();
      Cookies.set('locale', updatedLocale);
      toggleLocale(updatedLocale, previousLocale);
    }
  });
};

loadPage(onReadyToggleLocale);
