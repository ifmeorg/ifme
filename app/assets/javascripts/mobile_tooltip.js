/*
**  Tooltip for the profile page on mobile devices
**  This script should ideally run on the profile page
**  Behaviour
    ========================
    - Enables the viewers tooltip to be shown on mobile devices when the
      parent element is clicked.
    - Toggle behaviour is implemented so that the tooltip can be both shown
      and dismissed
*/

var onReadyMobileTip = function() {
  var MEDIUM_BREAKPOINT = 640;

  if ($(window).width() <= MEDIUM_BREAKPOINT) {
    $('.some_focus_text').click(function () {
      var child = $(this).children('.yes_title').eq(0);
      var title = child.prop('title');

      child.tooltip({
        content: title,
        position: { my: 'left+40 top+25', at: 'left top', of: $(this) }
      });

      var tooltipId = $(child).attr('aria-describedby');
      if (tooltipId) {
        child.tooltip('close');
      } else {
        child.tooltip('open');
      }
    });
  }
};

$(document).on("page:load ready", onReadyMobileTip);
