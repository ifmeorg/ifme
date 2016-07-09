describe("Moments", function() {

  var newOrEdit;
  var isAllAlliesInputBoxIsChecked;
  var selectAllAlliesWhoCanViewMomement;
  var setViewersCheckBoxToNotBeSelected;
  var unselectAllAlliesWhoCanViewMoment;

    beforeAll(function() {
    var elements = [];
    elements.push("<div id='test_body'></div>");
    elements.push("<label id='viewers_label'></label>");
    elements.push("<input type='checkbox' id='viewers'></input>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }

    newOrEdit = spyOn(window, 'newOrEdit');
    isAllAlliesInputBoxIsChecked = spyOn(window, 'isAllAlliesInputBoxIsChecked');
    selectAllAlliesWhoCanViewMomement = spyOn(window, 'selectAllAlliesWhoCanViewMomement');

    setViewersCheckBoxToNotBeSelected = spyOn(window, 'setViewersCheckBoxToNotBeSelected');

    unselectAllAlliesWhoCanViewMoment = spyOn(window, 'unselectAllAlliesWhoCanViewMoment');
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

      expect(isAllAlliesInputBoxIsChecked).toHaveBeenCalled();
  });

  it("has selected all allies who can view moment when ALL_ALLIES is selected",  function() {
      isAllAlliesInputBoxIsChecked.and.returnValue(true);

      $('#viewers').change();

      expect(selectAllAlliesWhoCanViewMomement).toHaveBeenCalled();
  });

  it("has not selected #viewers checkbox when ALL_ALLIES is selected",  function() {
      isAllAlliesInputBoxIsChecked.and.returnValue(true);

      $('#viewers').change();

      expect(setViewersCheckBoxToNotBeSelected).toHaveBeenCalled();
  });

  it("has set #viewers_label text to NO_ALLIES when ALL_ALLIES is selected", function() {
      isAllAlliesInputBoxIsChecked.and.returnValue(true);

      expect($('#viewers_label').text()).toBe(NO_ALLIES);
  });

  it("has unselected all allies who can view the moment when NO_ALLIES is selected", function() {
      isAllAlliesInputBoxIsChecked.and.returnValue(false);

      $('#viewers').change();

      expect(unselectAllAlliesWhoCanViewMoment).toHaveBeenCalled();
  });

  it("has not selected #viewers checkbox when NO_ALLIES is selected", function () {
      isAllAlliesInputBoxIsChecked.and.returnValue(false);

      $('#viewers').change();

      expect(setViewersCheckBoxToNotBeSelected).toHaveBeenCalled();
  });

  it("has set #viewers_label text to ALL_ALLIES when NO_ALLIES is selected", function() {
      isAllAlliesInputBoxIsChecked.and.returnValue(false);

      expect($('#viewers_label').text()).toBe(ALL_ALLIES);
  });
});
