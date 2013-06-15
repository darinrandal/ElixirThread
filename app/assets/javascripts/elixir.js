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

	$('.rate_post').click(function(e) {
		e.preventDefault();
		var token = $("meta[name=csrf-token]").attr('content');
		var t = $(this);
		var returned = "";
		var attack = t.parent().parent().find('.ratings');
		attack.fadeOut('fast', function() {
			$.ajax({
				type: "POST",
				url: "/ratings",
				data: { 
					post_id: t.attr('pid'),
					rating_type: t.attr('rid'),
					authenticity_token: token
				}
			}).done(function(rtn) {
				attack.html(rtn);
				attack.fadeIn('fast');
			}).fail(ajaxFail);
		});
	});

	$('.edit_post').click(function(e) {
		e.preventDefault();
		var t = $(this);
		var id = t.attr('href').split('/')[2];
		$.ajax({
			type: "get",
			url: "/posts/" + id + "/inline"
		}).done(function(data) {
			$('#content' + id).html(data);
		}).fail(ajaxFail);
	});
}

function ajaxFail(jqXHR, textStatus)
{
	alert('Ajax Fail: ' + textStatus);
}