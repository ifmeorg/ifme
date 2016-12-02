describe("ContributorsReadMore", function() {
	var checkFeature;
  	it("has called contributorReadMoreFeature", function() {
    	checkFeature = spyOn(window, 'contributorReadMoreFeature');
    	contributorReadMoreFeature();
    	expect(checkFeature).toHaveBeenCalled();
  	});

	it("has called readMoreHideContent", function(){
  		checkFeature = spyOn(window, 'readMoreHideContent');
  		readMoreHideContent();
  		expect(checkFeature).toHaveBeenCalled();
  	});

  it("invokes toggleProfileBlurb event", function() {
    checkFeature = spyOn(window, 'toggleProfileBlurb');
    toggleProfileBlurb();
    expect(checkFeature).toHaveBeenCalled();
  });
});


