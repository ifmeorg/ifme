describe("Strategies", function() {
  var newOrEdit;
  var isAllAlliesInputBoxIsChecked;

  beforeAll(function() {
    $(document.body).addClass("strategies new");

    var elements = [];
    elements.push("<div id='test_body'></div>");
    elements.push("<label id='viewers_label'></label>");
    elements.push("<input type='checkbox' id='viewers_all'></input>");
    elements.push("<input type='checkbox' name='strategy[viewers][]'></input>");
    elements.push("<input type='checkbox' name='strategy[comment][]'></input>");
    elements.push("<div id='moment_tag_usage' class='display_none'></div>");
    elements.push("<div id='showTaggedMoments' class='display_inline_block'></div>");
    elements.push("<div id='hideTaggedMoments' class='display_none'></div>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }

    newOrEdit = spyOn(window, 'newOrEdit');
    isAllAlliesInputBoxIsChecked = spyOn(window, 'isAllAlliesInputBoxIsChecked');
  });

  afterAll(function() {
    $("#test_body").remove();
    $("body").removeClass("strategies new");
  });

	it("has selected all allies who can view the strategy when \"Select all\" is selected",  function() {
    newOrEdit.and.returnValue(true);

    onReadyStrategies();

    $('#viewers_all').click();

    expect($(":checkbox[name='strategy[viewers][]']").eq(0).prop("checked")).toBe(true);
  });

  it("has unselected all allies who can view the strategy when \"Select all\" is unselected", function() {
    newOrEdit.and.returnValue(true);

    onReadyStrategies();
    
    $('#viewers_all').prop("checked", true);

    $('#viewers_all').click();

    expect($(":checkbox[name='strategy[viewers][]']").eq(0).prop("checked")).toBe(false);
  });

  it("test tagged moments hidden", function() {
    // hidden tagged moments
    expect($('#moment_tag_usage').hasClass("display_none")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_inline_block")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_none")).toBe(true);
    showTaggedMoments();
	});

  it("test tagged moments shown", function() {
    // shown tagged moments
    expect($('#moment_tag_usage').hasClass("display_block")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_none")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_inline_block")).toBe(true);
    hideTaggedMoments();
	});

  it("test tagged moments re-hidden", function() {
    // hidden tagged moments
    expect($('#moment_tag_usage').hasClass("display_none")).toBe(true);
    expect($('#showTaggedMoments').hasClass("display_inline_block")).toBe(true);
  	expect($('#hideTaggedMoments').hasClass("display_none")).toBe(true);
	});
});
