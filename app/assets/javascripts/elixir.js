// Turbolinks pageload and jQuery(document).ready() are binded to this, use it!
function documentReady()
{
	unbindOld();

	$('.load_events').click(function(e) {
		e.preventDefault();
		var div = $(this).parent().parent().parent().parent().next('div');
		var url = $(this).attr('href');
		var id = url.split('/')[2];
		if(div.html() == '') {
			$.ajax({
				type: "get",
				url: url
			}).done(function(data) {
				div.html(data).slideToggle('fast');
			}).fail(ajaxFail);
		} else {
			div.slideToggle('fast');
		}
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
			$('.send_form-' + id).bind('ajax:success', function(evt, data, status, xhr) {
				$('#post' + id).replaceWith(xhr.responseText);
				documentReady();
			});
		}).fail(ajaxFail);
	});

	$('#edit_user').submit(function() {
		var input = $('#user_current_password');
		var label = $('#user_current_password_label');
		var avatar = $('#user_avatar');

		if(passwordCheck() == false)
			return false;

		if(avatarCheck() == false)
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

	$('#new_post').submit(function() {
		var text = $('#post_content');
		if(text.val() == '') {
			if($('.chill-box').length == 0)
				$('#reply_box').before('<div class="chill-box"><span class="r00">Error:</span> Your cannot make a blank post :(</div>');

			text.focus();
			return false;
		}
		return true;
	});

	$('.p_field').keyup(passwordCheck);
	$('#user_avatar').change(avatarCheck);

	$('#new_post').bind('ajax:success', function(evt, data, status, xhr) {
		$('#reply_box').before(xhr.responseText);
		$('.post-container').last().slideDown('slow', function() {
			$("html, body").animate({ scrollTop: $('.forum_post').last().offset().top }, 1000);
		});
		$('#post_content').val('');
		documentReady();
	}).bind('ajax:before', function() {
		$('.chill-box').remove();
	});

	$('.del-ajax').click(function(e) {
		e.preventDefault();
		if(confirm("Are you sure you wish to delete this post?") == false)
			return false;

		var url = $(this).attr('href');
		var id = url.split('/')[2];

		$.ajax({
			type: "delete",
			url: url
		}).done(function(data) {
			if(data == 'true')
				$('#post' + id).slideUp('slow');
		}).fail(ajaxFail);
	});
}

function ajaxFail(jqXHR, textStatus)
{
	alert('Ajax Fail: ' + textStatus);
}

function avatarCheck()
{
	var avatar = $('#user_avatar');
	if(avatar.val() != '')
	{
		ext = avatar.val().split('.').pop();
		if(ext != 'png' && ext != 'jpg' && ext != 'gif' && ext != 'jpeg') {
			if($('#file_notif').length == 0)
				avatar.after('<p id="file_notif" class="min_padding r00">You can only upload images as an avatar</p>');

			return false;
		} else {
			$('#file_notif').remove();
		}
	}
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

function unbindOld()
{
	$('.load_events').off();
	$('.forum_post').off();
	$('.rate_post').off();
	$('.edit_post').off();
	$('#edit_user').off();
	$('.p_field').off();
	$('#new_post').off();
	$('.del-ajax').off();
}






