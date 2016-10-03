var onReadyMoments = function() {
	if (newOrEdit(['moments'])) {
		$('#viewers_all').click(function(){
			$(":checkbox[name='moment[viewers][]']").prop("checked", $(this).prop("checked"));
		});
	}
};

$(document).on("page:load ready", onReadyMoments);
