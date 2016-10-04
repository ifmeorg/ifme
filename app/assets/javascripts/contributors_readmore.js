var readMoreHideContent = function() {
  $('.read_more_content').addClass('hide_content');
  $('.read_more_show').removeClass('hide_content');
};

var readMoreShowContent = function(){
  $('.read_more_show').on('click', function() {
    $(this).fadeOut(400, function(){
      $(this).next('.read_more_content').removeClass('hide_content').slideDown(1000);
      $(this).addClass('hide_content');
    });
  });
};

var contributorReadMoreFeature = function(){
  var profileTextLength = 0;
  const maxProfileLength = 120;
	var visibleProfileText, invisibleProfileText;
  var contributorProfile = $('.contributor_profile');

	contributorProfile.each(function() {
		profileTextLength = $(this).text().length;
    if (profileTextLength > maxProfileLength){
      visibleProfileText = $(this).text().substr(0, maxProfileLength);
      invisibleProfileText = $(this).text().substr(maxProfileLength, profileTextLength - maxProfileLength);

      var profileContent = visibleProfileText + '<span class="read_more_show hide_content">'+ I18n.t('ellipsis') +'</span><span class="read_more_content">' + invisibleProfileText + '</span>';

      $(this).html(profileContent);
      readMoreHideContent();
    }
	});

  readMoreShowContent();
};

$(document).on("page:load ready", contributorReadMoreFeature);