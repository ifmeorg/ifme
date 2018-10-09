/* eslint-disable no-param-reassign */
(function ($) {
  const { ready } = $.fn;
  $.fn.ready = function (fn) {
    if (this.context === undefined) {
      // The $().ready(fn) case.
      ready(fn);
    } else if (this.selector) {
      ready($.proxy(function () {
        $(this.selector, this.context).each(fn);
      }, this));
    } else {
      ready($.proxy(function () {
        $(this).each(fn);
      }, this));
    }
  };
}(jQuery));
/* eslint-enable no-param-reassign */
