describe("Strategies", function() {
  var newOrEdit;
  var isShow;
  var isAllAlliesInputBoxIsChecked;

  beforeEach(function() {
    loadFixtures("strategies.html");
    newOrEdit = spyOn(window, 'newOrEdit');
    isShow = spyOn(window, 'isShow');
    isAllAlliesInputBoxIsChecked = spyOn(window, 'isAllAlliesInputBoxIsChecked');
  });

	it("has selected all allies who can view the strategy when \"Select all\" is selected",  function() {
    expect($(":checkbox[name='strategy[viewers][]']").eq(0).prop("checked")).toBe(false);
    newOrEdit.and.returnValue(true);
    onReadyViewers();
    $('#viewers_all').click();
    expect($(":checkbox[name='strategy[viewers][]']").eq(0).prop("checked")).toBe(true);
  });

  it("has unselected all allies who can view the strategy when \"Select all\" is unselected", function() {
    newOrEdit.and.returnValue(true);
    onReadyViewers();
    $('#viewers_all').prop("checked", true);
    $('#viewers_all').click();
    expect($(":checkbox[name='strategy[viewers][]']").eq(0).prop("checked")).toBe(false);
  });

  it("test tagged moments hidden on page load", function() {
    isShow.and.returnValue(true);
    onReadyStrategies();
    expect($('#moment_tag_usage').hasClass("display_none")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_inline_block")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_none")).toBe(true);
	});

  it("test tagged moments shown on toggle", function() {
    isShow.and.returnValue(true);
    onReadyStrategies();
    $('#showTaggedMoments').click();
    expect($('#moment_tag_usage').hasClass("display_block")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_none")).toBe(true);
    expect($('#hideTaggedMoments').hasClass("display_inline_block")).toBe(true);
	});

  it("test tagged moments hidden on toggle", function() {
    isShow.and.returnValue(true);
    onReadyStrategies();
    $('#showTaggedMoments').click();
    $('#hideTaggedMoments').click();
    expect($('#moment_tag_usage').hasClass("display_none")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_inline_block")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_none")).toBe(true);
	});
});
