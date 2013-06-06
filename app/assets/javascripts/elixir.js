// Turbolinks pageload and jQuery(document).ready() are binded to this, use it!
function documentReady()
{
	$('.load_events').click(function() {
		$(this).parent().parent().parent().parent().next('div').slideToggle('fast');
	});

	$('.forum_post').hover(function() {
		$(this).find('.rate_post').fadeIn('fast');
	}, function() {
		$(this).find('.rate_post').fadeOut('fast');
	});
}