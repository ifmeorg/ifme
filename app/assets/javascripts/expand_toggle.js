var onReadyExpandToggle = function() {
  if (newOrEdit(["moments", "strategies"])) {
    $(".expand_toggle").click(function(event) {
  		var toggleID = $(this).data("toggle");
  		$(toggleID).toggle();
  		$(this).find(".toggle_button i").toggleClass("fa-caret-down");
  		$(this).find(".toggle_button i").toggleClass("fa-caret-up");
  		event.preventDefault();
  	});
	}
};

document.addEventListener("turbolinks:load", onReadyExpandToggle);
