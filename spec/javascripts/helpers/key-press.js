module.exports = function(key) {
  const event = jQuery.Event("keyup");
  event.which = key;
  event.keyCode = key;
  $(document).trigger(event);
};
