//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//jQuery.ajaxSetup({
//	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
//})


$(document).ready(function() {
	
	// User edit form AJAX
	$('form.edit_user').submit(function(e) {
		e.preventDefault();
		var valuesToSubmit = $(this).serialize();
		$.ajax({
			type: "POST",
			url: $(this).attr("action"),
			data: valuesToSubmit,
			dataType: "script",
		});
		return false;
	});
	
	$('form#new_micropost').submit(function(e) {
		e.preventDefault();
		var micropost = $(this).serialize();
		$.ajax({
			type: "POST",
			url: $(this).attr("action"),
			data: micropost,
			dataType: "script",
		});
		return false;
	}); 

		
})

function charCount(val) {
	var len = val.value.length,
		$count = $('div.char_count'),
		$button = $('input.btn');
	
	if ( len <= 130 ) {
	 	$count.removeClass('low').text(140-len);
	 	$button.attr("disabled", false);
	}
	else if ( len > 140 ) {
		$count.addClass('low').text(140-len);
		$button.attr("disabled", true);
	}
	else {
		$count.addClass('low').text(140-len);
		$button.attr("disabled", false);
	}
}
