describe("Meetings", function() {
  	it("has called newOrEdit", function() {
    	var newOrEdit = spyOn(window, 'newOrEdit');
    	onReadyMeetings();
    	expect(newOrEdit).toHaveBeenCalled();
  	});
});
