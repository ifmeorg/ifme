var onReadyStrategiesModal = function() {
	$("#myBtn").click(function() {
		$("#myModal").show();
	});

	$(".close").click(function() {
		$(this).parent().parent().hide();
	})

	$(document).click(function(e) {
		if($(e.target).is('#myModal')) {
				$("#myModal").hide();
		  }
	})
};

$(document).on("page:load ready", onReadyStrategiesModal);

