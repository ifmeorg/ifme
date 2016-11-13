(function () {
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

  $(document).on("page:load ready", function () {
    // Allow this script to only be run on the profile page

    if (window.location.pathname !== "/profile") return false;

    var toggleCount = 0;

    // Ensure the script is activated on mobile devices only
    // Max-width: 768px

    if ($(window).width() <= 768) {
      $(".some_focus_text").on("click", function () {
        var child = $(this).children(".yes_title").eq(0),
            title = child.prop("title");

        child.tooltip({
          content: title,
          position: { my: "top-10 left+25", at: "top left", of: $(this) }
        });

        toggleCount++;

        toggleCount % 2 === 1 ? child.tooltip("open") : child.tooltip("close");
      });
    }
  });
}());
