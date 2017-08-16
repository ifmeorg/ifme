function convert_opacity(elem){
  return Math.round(
    $(`#${elem}`).css('opacity') * 10
  ) / 10
}

function keyPress(key) {
  const event = jQuery.Event("keyup");
  event.which = key;
  event.keyCode = key;
  $(document).trigger(event);
}

function getCookie(cname) {
  const name = `${cname}=`;
  const decodedCookie = decodeURIComponent(document.cookie);
  const ca = decodedCookie.split(";");
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) === " ") {
      c = c.substring(1);
    }
    if (c.indexOf(name) === 0) {
      return c.substring(name.length, c.length);
    }
  }
  return null;
}
