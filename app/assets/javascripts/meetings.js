$(function(){
	$('#meeting_date').datetimepicker({
		timepicker: false,
		format:'d/m/Y'
	});
	$('#meeting_time').datetimepicker({
		format: 'g:i a',
		formatTime:'g:i a',
	  	datepicker: false
	});
});