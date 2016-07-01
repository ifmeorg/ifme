describe("Moments", function() {
  var NO_ALLIES;
  var ALL_ALLIES;
  var newOrEdit;

  beforeAll(function() {
    var elements = [];
    elements.push("<div id='test_body'></div>");
    elements.push("<label id='viewers_label'></label>");
    elements.push("<input type='checkbox' id='viewers'></input>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }

    NO_ALLIES = "Unselect all";
    ALL_ALLIES = "Select all";
    newOrEdit = spyOn(window, "newOrEdit");
  });

  it("test no functions called", function() {
    expect(newOrEdit).not.toHaveBeenCalled();
  });

	it("test onReadyMoments to be called", function() {
    onReadyMoments();
    expect(newOrEdit).toHaveBeenCalled();
    expect($('#viewers_label').text()).toBe("");
  });

  it("test onReadyMoments and newOrEdit to be called", function() {
    $("body").addClass("moments new");
    newOrEdit.and.returnValue(true);

    onReadyMoments();

    expect($('#viewers_label').text()).toBe(ALL_ALLIES);
  });

  it("test newOeEdit in onReadyMoments to be called", function() {
    onReadyMoments();

    expect(newOrEdit).toHaveBeenCalled();
  });

   it("has marked the check box when viewers_label text is ALL_ALLIES", function() {
      var isChecked = spyOn(window, 'isChecked').and.returnValue(true);
      var selectAuthorizedViewers = spyOn(window, 'selectAuthorizedViewers');
      newOrEdit.and.returnValue = true;

      onReadyMoments();
      $('#viewers').change();

      expect(selectAuthorizedViewers).toHaveBeenCalled();
  });


});
