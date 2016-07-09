describe("Moments", function() {

  var newOrEdit;
  var labelTextIsAllAllies;

    beforeAll(function() {
    var elements = [];
    elements.push("<div id='test_body'></div>");
    elements.push("<label id='viewers_label'></label>");
    elements.push("<input type='checkbox' id='viewers'></input>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }

    newOrEdit = spyOn(window, 'newOrEdit');
    labelTextIsAllAllies = spyOn(window, 'labelTextIsAllAllies');
  });

  it("has called newOrEdit when onReadyMoments is executed", function () {
      onReadyMoments();

      expect(newOrEdit).toHaveBeenCalled();
  });

  it("has set NO_ALLIES value to unselect all when creating or editing a new moment", function() {
    newOrEdit.and.returnValue(true);

    onReadyMoments();

    expect(NO_ALLIES).toBe("Unselect all");
  });

  it("has set ALL_ALLIES value to select all when creating or editing a new moment", function() {
    newOrEdit.and.returnValue(true);

    onReadyMoments();

    expect(ALL_ALLIES).toBe("Select all");
  });

  it("has set the default value of viewers_label text to ALL_ALLIES when creating or editing a new moment", function() {
    newOrEdit.and.returnValue(true);

    expect($('#viewers_label').text()).toBe(ALL_ALLIES);
  });

  it("has called lableTextIsAllAllies when input box is checked", function() {
      newOrEdit.and.returnValue(true);

     $('#viewers').change();

      expect(labelTextIsAllAllies).toHaveBeenCalled();
  });

  xit("test onReadyMoments to be called", function() {
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
