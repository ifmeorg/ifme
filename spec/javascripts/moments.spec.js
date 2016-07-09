describe("Moments", function() {
  var NO_ALLIES = "Unselect all";
  var ALL_ALLIES = "Select all";
  var newOrEdit;

    beforeAll(function() {
    var elements = [];
    elements.push("<div id='test_body'></div>");
    elements.push("<label id='viewers_label'></label>");
    elements.push("<input type='checkbox' id='viewers'></input>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }

    newOrEdit = spyOn(window, 'newOrEdit');
  });

  it("has called newOrEdit when onReadyMoments is executed", function () {
      onReadyMoments();

      expect(newOrEdit).toHaveBeenCalled();
  });

  it("test onReadyMoments to be called", function() {
    onReadyMoments();
    expect(newOrEdit).toHaveBeenCalled();
    expect($('#viewers_label').text()).toBe("");
  });

  xit("test onReadyMoments and newOrEdit to be called", function() {
    $("body").addClass("moments new");
    onReadyMoments();
    expect($('#viewers_label').text()).toBe(ALL_ALLIES);
  });

  it("test newOeEdit in onReadyMoments to be called", function() {
    onReadyMoments();
    expect(newOrEdit).toHaveBeenCalled();
  });
});
