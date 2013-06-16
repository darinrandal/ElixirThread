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

	$('#edit_user').submit(function() {
		var input = $('#user_current_password');
		var label = $('#user_current_password_label');

		if(passwordCheck() == false)
			return false;

		if(input.val() == '')
		{
			input.focus();
			label.addClass('r00');
			input.keyup(function() {
				if(input.val() == '') {
					label.addClass('r00');
				} else {
					label.removeClass('r00');
				}
			})
			return false;
		}
	});

	$('.p_field').keyup(passwordCheck);
}

function ajaxFail(jqXHR, textStatus)
{
	alert('Ajax Fail: ' + textStatus);
}

function passwordCheck()
{
	var pass = $('#user_password');
	var pass_conf = $('#user_password_confirmation');

	if((pass.val() != '' && pass_conf.val() != '') && (pass.val() != pass_conf.val()))
	{
		if($('#pass_notif').length == 0)
			pass_conf.after('<p id="pass_notif" class="min_padding r00">The passwords you entered do not match</p>');

		return false;
	} else {
		$('#pass_notif').remove();
		return true;
	}
}







