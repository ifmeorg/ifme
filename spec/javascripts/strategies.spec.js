describe("Strategies", function() {
  var NO_ALLIES = "Unselect all";
  var ALL_ALLIES = "Select all";
  beforeAll(function() {
    $("body").addClass("strategies new");

    $("body")
    .prepend(
      $("<div>")
      .attr("id", "test_body")
      .append(
        $('<label>')
        .attr("id", "viewers_label")
        .text(ALL_ALLIES),

        $('<input>')
        .attr({
          "type": "checkbox",
          "id": "viewers"
        }),

        $('<input>')
        .attr({
          "type": "checkbox",
          "name": "strategy[viewers][]"
        }),

        $('<input>')
        .attr({
          "type": "checkbox",
          "name": "strategy[comment]"
        }),

        $('<div>')
        .attr({
          "id": "moment_tag_usage"
        })
        .addClass("display_none"),

        $('<div>')
        .attr({
          "id": "showTaggedMoments"
        })

        .addClass("display_inline_block"),

        $('<div>')
        .attr({
          "id": "hideTaggedMoments"
        })
        .addClass("display_none")
      )
    )
    onReadyStrategies();
  });
  afterAll(function() {
    $("#test_body").remove();
    $("body").removeClass("strategies new");
  });
	it("test all viewers not checked", function() {
    // all are unchecked
    expect($(":checkbox[name='strategy[viewers][]']").prop("checked")).toBe(false);
    expect($(":checkbox[id='viewers']").prop("checked")).toBe(false);
  	expect($('#viewers_label').text()).toBe(ALL_ALLIES);
    expect($(":checkbox[name='strategy[comment]']").prop("checked")).toBe(false);
  });
  it("test all viewers checked", function() {
    // check all
    $(":checkbox[id='viewers']").prop("checked", true);
    onChangeViewers.apply($(":checkbox[id='viewers']")[0]);
    expect($(":checkbox[name='strategy[viewers][]']").prop("checked")).toBe(true);
    expect($(":checkbox[id='viewers']").prop("checked")).toBe(false);
  	expect($('#viewers_label').text()).toBe(NO_ALLIES);
  });
  it("test all viewers unchecked", function() {
    // uncheck all
    $(":checkbox[id='viewers']").prop("checked", true);
    onChangeViewers.apply($(":checkbox[id='viewers']")[0]);
    expect($(":checkbox[name='strategy[viewers][]']").prop("checked")).toBe(false);
    expect($(":checkbox[id='viewers']").prop("checked")).toBe(false);
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
