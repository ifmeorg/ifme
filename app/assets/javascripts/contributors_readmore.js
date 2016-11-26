var readMoreHideContent = function() {
  $('.read_more_content').addClass('hide_content');
  // Hide button to collapse profile blurb
  $('.read_less_show').addClass('hide_content');
  $('.read_more_show').removeClass('hide_content');
};

var readMoreShowContent = function(){
  $('.read_more_show').on('click', function() {
    $(this).fadeOut(400, function(){
      $(this).next('.read_more_content').removeClass('hide_content').show();
      // Unhide collapse button along with remainder of profile blurb
      $(this).next().next('.read_less_show').removeClass('hide_content').show();
      $(this).addClass('hide_content');
    });
  });
};

// Event handler for collapse button
var readLessHideContent = function(){
  $('.read_less_show').on('click', function() {
    $(this).fadeOut(400, function(){
      $(this).prev('.read_more_content').addClass('hide_content').hide();
      $(this).prev().prev('.read_more_show').removeClass('hide_content').show();
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

      // Add [Less] collapse button to profile blurb
      var profileContent = visibleProfileText + '<span class="read_more_show hide_content">'+ I18n.t('ellipsis') +'</span><span class="read_more_content">' + invisibleProfileText + '</span><span class="read_less_show"> [Less]</span>';

      $(this).html(profileContent);
      readMoreHideContent();
    }
  });

  readMoreShowContent();
  // [Less] collapse button
  readLessHideContent();
};

$(document).on("page:load ready", contributorReadMoreFeature);