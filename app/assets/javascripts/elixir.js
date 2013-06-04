// Turbolinks pageload and jQuery(document).ready() are binded to this, use it!
function documentReady()
{
	$('.load_events').click(function() {
		var uid = $(this).attr('uid');

		var e = $(this).parent().parent().parent().parent().next('div')
		if(e.html() != '') {
			e.slideToggle('fast');
			return;
		}

		$.ajax({
			url: '/events/ajax/' + uid,
			contentType: 'text/html',
			cache: false
		}).done(function(data) {
		  e.html(data).slideDown('fast');
		}).fail(function(jqXHR, textStatus) {
		  alert( "Request failed: " + textStatus );
		});
	});

	$('.forum_post').hover(function() {
		$(this).find('.rate_post').fadeIn('fast');
	}, function() {
		$(this).find('.rate_post').fadeOut('fast');
	});
}