function docReady()
{
	$('.load_events').click(function() {
		var uid = $(this).attr('uid');

		$.get('/events/' + uid + '.json', function(data) {
			//$('.result').html(data);
			alert(data);
			console.log(data);
		});
	});
}

$(document).ready(docReady);
document.addEventListener("page:load", docReady);