describe("Header", function() {

  beforeEach(function() {
    // mocking the DOM
    // "fresh" DOM will be created before
    //  calling each describe()
    var elements = [];
    elements.push("<div id='expand_moment'></div>");
    elements.push("<div id='title_expand'></div>");
    elements.push("<div id='moment'></div>");
    elements.push("<div id='header'></div>");
    elements.push("<div id='header_space'></div>");
    elements.push("<div id='me'></div>");
    elements.push("<div id='expand_me'></div>");
    elements.push("<div id='small_nav'></div>");
    elements.push("<div id='expand_nav'></div>");
    for (var i = 0; i < elements.length; i++) {
      $(document.body).append(elements[i]);
    }
  });



  describe("onReadyHeader", function() {
    it("has called setHeight", function() {
      var spy = spyOn(window, 'setHeight');
      onReadyHeader();
      expect(spy).toHaveBeenCalled();
    });

    it("toggles expand_me visibility", function (){
      var click_flag = 0;
      onReadyHeader();
      var spy1 = spyOn(window, 'hideSmallTopNav');
      var spy2 = spyOn(window, 'showExpandMe');
      expandButton({ data: click_flag });
      expect(spy1).toHaveBeenCalled();
      expect(spy2).toHaveBeenCalled();
    });

    it("toggles small_nav visibility", function (){
      onReadyHeader();
      var spy0 = spyOn(window, 'showSmallTopNav');
      var spy1 = spyOn(window, 'hideSmallTopNav');
      var spy2 = spyOn(window, 'hideExpandMe');
      $('#expand_nav').click();
      $('#small_nav').addClass('display_none');
      $('#expand_nav').click();
      expect(spy0).toHaveBeenCalled();
      expect(spy1).toHaveBeenCalled();
      expect(spy2).toHaveBeenCalled();
    });

    it("handles expand_moment_button mouseover event", function() {
      var spy0 = spyOn(window, 'setHeight');
      var spy1 = spyOn(window, 'hideExpandMe');
      var spy2 = spyOn(window, 'showExpandMoment');
      $("#expand_moment").addClass("display_none");
      expandMomentMouseover();
      expect(spy0).toHaveBeenCalled();
      expect(spy1).toHaveBeenCalled();
      expect(spy2).toHaveBeenCalled();
    });

    it("calls hideExpandMoment() and setHeight() on $('#header').mouseleave", function() {
      var spy0 = spyOn(window, 'setHeight');
      var spy1 = spyOn(window, 'hideExpandMoment');
      $('#expand_moment').length = true;
      $('#expand_moment').addClass('display_block');
      headerMouseLeave();
      expect(spy0).toHaveBeenCalled();
      expect(spy1).toHaveBeenCalled();
    });

    it("calls setHeight() on widnow resize", function() {
      var spy = spyOn(window, 'setHeight');
      $(window).resize();
      expect(spy).toHaveBeenCalled();
    });
  });



  describe("hideSmallTopNav", function() {
    beforeEach(function() {
      // adding the class to make sure shideSmallTopNav gets rid of it
      $('#small_nav').addClass('display_block');
    });

    it("has changed small_nav class", function (){
      hideSmallTopNav();
      expect($('#small_nav').hasClass('display_block')).toBeFalsy();
      expect($('#small_nav').hasClass('display_none')).toBeTruthy();
    });

    it("has set expand_nav capacity", function() {
      hideSmallTopNav();
      var o1 = parseFloat($('#expand_nav').css('opacity')).toFixed(1);
      expect(o1).toBe('1.0');
    });
  });


  describe("showSmallTopNav", function() {
    beforeEach(function() {
      // adding the class to make sure showSmallTopNav gets rid of it
      $('#small_nav').addClass('display_none');
    });

    it("has changed small_nav class", function (){
      showSmallTopNav();
      expect($('#small_nav').hasClass('display_none')).toBeFalsy();
      expect($('#small_nav').hasClass('display_block')).toBeTruthy();
    });

    it("has set expand_nav capacity", function() {
      showSmallTopNav();
      var o1 = parseFloat($('#expand_nav').css('opacity')).toFixed(1);
      expect(o1).toBe('0.8');
    });
  });



  describe("hideExpandMe", function() {
    beforeEach(function () {
      // adding the class to make sure hideExpandMe gets rid of it
      $('#expand_me').addClass('display_block');
    });

    it("has changed expand_me class", function() {
      hideExpandMe();
      expect($('#expand_me').hasClass('display_block')).toBeFalsy();
      expect($('#expand_me').hasClass('display_none')).toBeTruthy();
    });

    it("has set me and title_expand opacity", function() {
      hideExpandMe();
      var o1 = parseInt($('#me').css('opacity'));
      var o2 = parseInt($('#title_expand').css('opacity'))
      expect(o1).toBe(1);
      expect(o2).toBe(1);
    });
  });



  describe("showExpandMe", function() {
    beforeEach(function () {
      // adding the class to make sure showExpandMe gets rid of it
      $('#expand_me').addClass('display_none');
    });

    it("has changed expand_me class", function() {
      showExpandMe();
      expect($('#expand_me').hasClass('display_none')).toBeFalsy();
      expect($('#expand_me').hasClass('display_block')).toBeTruthy();
    });

    it("has set me and title_expand opacity", function() {
      showExpandMe();
      var o1 = parseFloat($('#me').css('opacity')).toFixed(1);
      var o2 = parseFloat($('#title_expand').css('opacity')).toFixed(1);
      expect(o1).toBe('0.8');
      expect(o2).toBe('0.8');
    });
  });



  describe("showExpandMoment", function() {
    beforeEach(function (){
      // adding the class to make sure showExpandMoment gets rid of it
      $('#expand_moment').addClass('display_none');
    });

    it("has set the expand_moment class", function() {
      showExpandMoment();
      expect($('#expand_moment').hasClass('display_none')).toBeFalsy();
      expect($('#expand_moment').hasClass('display_block')).toBeTruthy();
    });
  });



  describe("hideExpandMoment", function() {
    beforeEach(function() {
      // adding the class to make sure hideExpandMe gets rid of it
      $('#expand_moment').addClass('display_block');
    });

    it("has changed expand_moment class", function() {
      hideExpandMoment();
      expect($('#expand_moment').hasClass('display_block')).toBeFalsy();
      expect($('#expand_moment').hasClass('display_none')).toBeTruthy();
    });

    it("has set moment and title_expand opacity", function() {
      expect($('#moment').css('opacity')).toBe('1');
      expect($('#title_expand').css('opacity')).toBe('1');
    });
  });



  describe("setHeight", function() {
    it("has set the height of header_space", function() {
      // testing for 2 arbitrarly chosen values
      $('#header').height(17);
      setHeight();
      expect($('#header_space').height()).toBe(17);

      $('#header').height(24);
      setHeight();
      expect($('#header_space').height()).toBe(24);
    });
  });


  // cleaning up mock DOM after each describe()
  afterEach(function (){
    $('#expand_moment').remove();
    $('#title_expand').remove();
    $('#moment').remove();
    $('#header').remove();
    $('#header_space').remove();
    $('#me').remove();
    $('#expand_me').remove();
    $('#small_nav').remove();
    $('#expand_nav').remove();
  });

});
