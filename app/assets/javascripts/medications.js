var onReadyMedications = function() {
    if ($('body').hasClass('medications new') || $('body').hasClass('medications edit') || $('body').hasClass('medications create') || $('body').hasClass('medications update')) {

    // Comment out for now because no longer working
    // function toTitleCase(str) {
    //   if (1 !== str.length) str = str.toLowerCase();
    //   return str.replace(/\b[a-z]/g, function(f){return f.toUpperCase()});
    // }

    // $("#medication_name").autocomplete({
    //   source: function (request, response) {
    //     $.getJSON(
    //       "http://dailymed.nlm.nih.gov/dailymed/services/v2/drugnames.json?drug_name=" + request.term,
    //       function (data) {
    //         var cleanedData = [];
    //         _.each(data.data, function(dataItem) {
    //           cleanedData.push(toTitleCase(dataItem.drug_name));
    //         })
    //         response(cleanedData);
    //       });
    //   },
    //   minLength: 3,
    //   select: function (event, ui) {
    //     var selectedObj = ui.item;
    //     $("#medication_name").val(selectedObj.value);
    //     return false;
    //   },
    //   open: function () {
    //     $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    //   },
    //   close: function () {
    //     $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    //   }
    // });
    // $("#medication_name").autocomplete("option", "delay", 100);

    $("#medication_refill").datepicker();
  }
};

$(document).on("page:load ready", onReadyMedications);
