describe("Moments", function() {
  var NO_ALLIES = "Unselect all";
  var ALL_ALLIES = "Select all";

    beforeAll(function() {
    var elements = [];
    elements.push("<div id='test_body'></div>");
    elements.push("<label id='viewers_label'></label>");
    elements.push("<input type='checkbox' id='viewers'></input>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }
  });

  it("test no functions called", function() {
    var newOrEdit = spyOn(window, "newOrEdit");
    expect(newOrEdit).not.toHaveBeenCalled();
  });
  it("test onReadyMoments to be called", function() {
    var newOrEdit = spyOn(window, "newOrEdit");
    onReadyMoments();
    expect(newOrEdit).toHaveBeenCalled();
    expect($('#viewers_label').text()).toBe("");
  });
  it("test onReadyMoments and newOrEdit to be called", function() {
    $("body").addClass("moments new");
    onReadyMoments();
    expect($('#viewers_label').text()).toBe(ALL_ALLIES);
    onReadyMoments();
  });
  it("test newOeEdit in onReadyMoments to be called", function() {
    var newOrEdit = spyOn(window, "newOrEdit");
    onReadyMoments();
    expect(newOrEdit).toHaveBeenCalled();
  });
});
