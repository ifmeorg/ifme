describe("ContributorsReadMore", function() {
	var checkFeature;
  	it("has called contributorReadMoreFeature", function() {
    	checkFeature = spyOn(window, 'contributorReadMoreFeature');
    	contributorReadMoreFeature();
    	expect(checkFeature).toHaveBeenCalled();
  	});

	it("has called readMoreShow", function() {
    	checkFeature = spyOn(window, 'readMoreShow');
    	contributorReadMoreFeature();
    	expect(checkFeature).toHaveBeenCalled();
  	});

});


