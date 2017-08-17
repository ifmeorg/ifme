var onReadyStrategiesModal = function() {
	$("#add_modal_button").click(function() {
		$("#premade_modal").show();
	});

	$(".close_premade_modal").click(function() {
		$(this).parent().parent().hide();
	})

	$(document).click(function(e) {
		if($(e.target).is('#premade_strategies')) {
				$("#premade_modal").hide();
		  }
	})
};

$(document).on("page:load ready", onReadyStrategiesModal);

