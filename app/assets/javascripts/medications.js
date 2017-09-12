var onReadyMedications = function() {
    if ($('body').hasClass('medications new') || $('body').hasClass('medications edit') || $('body').hasClass('medications create') || $('body').hasClass('medications update')) {
    $("#medication_refill").datepicker();
  }
};

loadPage(onReadyMedications);
