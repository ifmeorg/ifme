describe("Moments", function() {
  beforeEach(function() {
    loadFixtures('moments.html');

    var newOrEdit = spyOn(window, 'newOrEdit');
    newOrEdit.and.returnValue(true);

    onReadyViewers();
  });

  it("has selected all allies who can view moment when \"Select all\" is selected",  function() {
    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(false);
    $('#viewers_all').click();
    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(true);
  });

  it("has unselected all allies who can view the moment when \"Select all\" is unselected", function() {
    $('#viewers_all').click();
    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(true);
    $('#viewers_all').click();
    expect($(":checkbox[name='moment[viewers][]']").eq(0).prop("checked")).toBe(false);
  });
});
