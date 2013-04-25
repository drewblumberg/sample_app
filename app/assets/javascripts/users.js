//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//jQuery.ajaxSetup({
//	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
//})


$(document).ready(function() {
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
})

