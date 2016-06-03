describe("test", function() {
  var NO_ALLIES = "Unselect all";
  var ALL_ALLIES = "Select all";
  beforeEach(function() {
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
	it("1", function() {
    // all are unchecked
    expect($(":checkbox[name='strategy[viewers][]']").prop("checked")).toBe(false);
    expect($(":checkbox[id='viewers']").prop("checked")).toBe(false);
  	expect($('#viewers_label').text()).toBe(ALL_ALLIES);
    expect($(":checkbox[name='strategy[comment]']").prop("checked")).toBe(false);

    // check all
    $(":checkbox[id='viewers']").prop("checked", true);
    onChangeViewers.apply($(":checkbox[id='viewers']")[0]);
    expect($(":checkbox[name='strategy[viewers][]']").prop("checked")).toBe(true);
    expect($(":checkbox[id='viewers']").prop("checked")).toBe(false);
  	expect($('#viewers_label').text()).toBe(NO_ALLIES);

    // uncheck all
    $(":checkbox[id='viewers']").prop("checked", true);
    onChangeViewers.apply($(":checkbox[id='viewers']")[0]);
    expect($(":checkbox[name='strategy[viewers][]']").prop("checked")).toBe(false);
    expect($(":checkbox[id='viewers']").prop("checked")).toBe(false);
  	expect($('#viewers_label').text()).toBe(ALL_ALLIES);
	});
});
