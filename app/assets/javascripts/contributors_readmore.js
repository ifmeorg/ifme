var contributorReadMoreFeature = (function(){
    var profileTextLength = 0;
	const maxProfileLength = 250;
	var visibleProfileText, invisibleProfileText;

	$('.contributor-profile').each(function(i){
		profileTextLength = $(this).text().length;

        if (profileTextLength > maxProfileLength){
            visibleProfileText = $(this).text().substr(0, maxProfileLength);
            invisibleProfileText = $(this).text().substr(maxProfileLength, profileTextLength - maxProfileLength);

            var profileContent = visibleProfileText + '<a href="#" class="read-more-show hide">...</a><span class="read-more-content">' 
                + invisibleProfileText + '</span>';
            
            $(this).html(profileContent);

            $('.read-more-content').addClass('hide')
            $('.read-more-show, .read-more-hide').removeClass('hide')
        }
	});

    $('.read-more-show').on('click', function(e){
        $(this).fadeOut(400, function(){
            $(this).next('.read-more-content').removeClass('hide').slideDown(1000);
            $(this).addClass('hide');
        });
        e.preventDefault();
    });
});


$(document).on("page:load ready", contributorReadMoreFeature);