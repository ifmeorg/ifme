$(document).on("page:load ready", function() {
	if ($('body').hasClass('search index') || $('body').hasClass('allies index')) {
		$("#search_location").autocomplete({
			source: function (request, response) {
				 $.getJSON(
					"http://gd.geobytes.com/AutoCompleteCity?callback=?&q="+request.term,
					function (data) {
					 response(data);
					}
				 );
			},
			minLength: 3,
			select: function (event, ui) {
				var selectedObj = ui.item;
				$("#search_location").val(selectedObj.value);
				return false;
			},
			open: function () {
				$(this).removeClass("ui-corner-all").addClass("ui-corner-top");
			},
			close: function () {
				$(this).removeClass("ui-corner-top").addClass("ui-corner-all");
			}
		});
		$("#search_location").autocomplete("option", "delay", 100);
	}
});