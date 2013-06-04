function docReady()
{
	$('.load_events').click(function() {
		var t = $(this);
		var uid = t.attr('uid');

		$.ajax({
			url: '/events/ajax/' + uid,
			contentType: 'text/html',
			cache: false
		}).done(function(data) {
		  t.parent().parent().parent().parent().css('margin-bottom', '0px !important').next('div').html(data).slideDown('fast');
		}).fail(function(jqXHR, textStatus) {
		  alert( "Request failed: " + textStatus );
		});
	});
}

$(document).ready(docReady);
document.addEventListener("page:load", docReady);