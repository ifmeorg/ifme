var onReadyMomentsAndStrategies = function() {
  if (newOrEdit(["moments", "strategies"])) {
    $(".expand_toggle").click(function(event) {
  		var toggleID = $(this).data("toggle");
  		$(toggleID).toggle();
  		$(this).find(".toggle_button i").toggleClass("fa-caret-down");
  		$(this).find(".toggle_button i").toggleClass("fa-caret-up");
  		event.preventDefault();
  	});

  	$("#viewers_all").click(function(){
  		$("#viewers_list :checkbox").prop("checked", $(this).prop("checked"));
  	});
	}
};

$(document).on("page:load ready", onReadyMomentsAndStrategies);
