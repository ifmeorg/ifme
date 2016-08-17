$(function(){
    var totalChars = 0;
	var max = 250;
	var visible, invisible;

    // For each contributor profile's content
	$('.character-limit').each(function(i){
		totalChars = $(this).text().length;

        // Creates a read-more button only if the content exceeds 250 chars
        if (totalChars > max){
            visible = $(this).text().substr(0, max);
            invisible = $(this).text().substr(max, totalChars - max);

            var content = visible + '<a href="#" class="read-more-show hide">...</a><span class="read-more-content">' + invisible + '</span>';
            $(this).html(content);

            // Hides overflow content
            $('.read-more-content').addClass('hide')
            $('.read-more-show, .read-more-hide').removeClass('hide')
        }
	});

    // On click, reveals overflow content
    $('.read-more-show').on('click', function(e){
        $(this).fadeOut(400, function(){
            $(this).next('.read-more-content').removeClass('hide').slideDown(1000);
            //$(this).next()slideDown(600);
            $(this).addClass('hide');
        });
        e.preventDefault();
    });
});
