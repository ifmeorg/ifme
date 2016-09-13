describe("ContributorsReadMore", function() {
	var checkFeature;
  	it("has called contributorReadMoreFeature", function() {
    	checkFeature = spyOn(window, 'contributorReadMoreFeature');
    	contributorReadMoreFeature();
    	expect(checkFeature).toHaveBeenCalled();
  	});

	it("has called readMoreShowContent", function() {
    	checkFeature = spyOn(window, 'readMoreShowContent');
    	contributorReadMoreFeature();
    	expect(checkFeature).toHaveBeenCalled();
  	});

	it("has called readMoreHideContent", function(){
  		checkFeature = spyOn(window, 'readMoreHideContent');
  		readMoreHideContent();
  		expect(checkFeature).toHaveBeenCalled();
  	});
});


