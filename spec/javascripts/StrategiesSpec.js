describe("Strategies", function() {
  var newOrEdit;
  var isAllAlliesInputBoxIsChecked;

  beforeEach(function() {
    loadFixtures("strategies.html");
    newOrEdit = spyOn(window, 'newOrEdit');
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

  it("test tagged moments hidden", function() {
    expect($('#moment_tag_usage').hasClass("display_none")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_inline_block")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_none")).toBe(true);
	});

  it("test tagged moments shown", function() {
    showTaggedMoments();
    expect($('#moment_tag_usage').hasClass("display_block")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_none")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_inline_block")).toBe(true);
	});

  it("test tagged moments re-hidden", function() {
    hideTaggedMoments();
    expect($('#moment_tag_usage').hasClass("display_none")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_inline_block")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_none")).toBe(true);
	});
});
