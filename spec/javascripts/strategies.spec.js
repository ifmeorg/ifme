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

	it("test all viewers not checked", function() {
    // all are unchecked
    newOrEdit.and.returnValue(true);

    onReadyStrategies();

    expect($(":checkbox[name='strategy[viewers][]']").prop("checked")).toBe(false);
    expect($(":checkbox[id='viewers_all']").prop("checked")).toBe(false);
  	expect($('#viewers_label').text()).toBe(ALL_ALLIES);
  });

  it("test all viewers checked", function() {
    // check all
    isAllAlliesInputBoxIsChecked.and.returnValue(true);
    $('#viewers_all').change();
  	expect($('#viewers_label').text()).toBe(NO_ALLIES);
  });

  it("test all viewers unchecked", function() {
    // uncheck all
    isAllAlliesInputBoxIsChecked.and.returnValue(false);
    $('#viewers_all').change();
  	expect($('#viewers_label').text()).toBe(ALL_ALLIES);
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
