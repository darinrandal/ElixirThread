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
		var url = $(this).attr('href');
		var id = url.split('/')[2];
		$.ajax({
			type: "get",
			url: url
		}).done(function(data) {
			$('#content' + id).html(data);
			$('.send_form-' + id).bind('ajax:success', function(evt, data, status, xhr){
				$('#content' + id).html(xhr.responseText);
			});
		}).fail(ajaxFail);
	});
}

function ajaxFail(jqXHR, textStatus)
{
	alert('Ajax Fail: ' + textStatus);
}