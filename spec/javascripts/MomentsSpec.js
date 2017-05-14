
describe("Moments", function() {
  beforeAll(function() {
    var newOrEdit;
    var elements = [];
    elements.push("<div class='yes_title'></div>");
    elements.push("<input type='checkbox' id='viewers_all'></input>");
    elements.push("<div id='viewers_list'><input type='checkbox' name='moment[viewers][]'></input></div>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }

    newOrEdit = spyOn(window, 'newOrEdit');
    newOrEdit.and.returnValue(true);

    onReadyMomentsAndStrategies();
  });

  afterAll(function() {
    $("#viewers_list").remove();
  });

  it("has selected all allies who can view moment when \"Select all\" is selected",  function() {
    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(false);

    $('#viewers_all').click();

    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(true);
  });

  it("has unselected all allies who can view the moment when \"Select all\" is unselected", function() {
    $('#viewers_all').prop("checked", true);

    $('#viewers_all').click();

    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(false);
  });
});
