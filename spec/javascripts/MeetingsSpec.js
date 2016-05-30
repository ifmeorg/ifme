describe("Meetings", function() {
  	it("has called newOrEdit", function() {
    	var spy = spyOn(window, 'newOrEdit');
    	onReadyMeetings();
    	expect(spy).toHaveBeenCalled();
  	});
});
