describe("Moments", function() {
  var newOrEdit;

  beforeAll(function() {
    var elements = [];
    elements.push("<input type='checkbox' id='viewers_all'></input>");
    elements.push("<input type='checkbox' name='moment[viewers][]'></input>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }

    newOrEdit = spyOn(window, 'newOrEdit');
  });

  it("has called newOrEdit when onReadyMoments is executed", function () {
    onReadyMoments();
    
    expect(newOrEdit).toHaveBeenCalled();
  });

  it("has selected all allies who can view moment when \"Select all\" is selected",  function() {
    newOrEdit.and.returnValue(true);

    onReadyMoments();

    $('#viewers_all').click();

    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(true);
  });

  it("has unselected all allies who can view the moment when \"Select all\" is unselected", function() {
    newOrEdit.and.returnValue(true);
    
    $('#viewers_all').prop("checked", true);

    $('#viewers_all').click();

    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(false);
  });
});
