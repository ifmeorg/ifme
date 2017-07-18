function convert_opacity(elem){
  return opacity = Math.round($('#'+elem).css('opacity') * 10) / 10
}

function keyPress(key) {
  var e = jQuery.Event("keyup");
  e.which = key;
  e.keyCode = key;
  $(document).trigger(e);
}
